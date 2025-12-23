import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:arbibot/core/services/langchain_service.dart';
import 'package:arbibot/features/common/repositories/database_repository.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  final chatModel = ref.watch(chatModelProvider);
  final databaseRepository = ref.watch(databaseRepositoryProvider);
  return ChatService(chatModel, databaseRepository);
});

class ChatService {
  final ChatOpenAI _chatModel;
  final DatabaseRepository _databaseRepository;

  ChatService(this._chatModel, this._databaseRepository);

  Stream<String> sendMessageStream({
    required String chatId,
    required String message,
  }) async* {
    // 1. Save User Message
    await _databaseRepository.saveMessage(
      chatId: chatId,
      role: 'user',
      content: message,
    );

    // 2. Create Prompt
    final prompt = PromptValue.string(message);

    // 3. Stream Response
    final stream = _chatModel.stream(prompt);
    
    String fullResponse = '';
    await for (final chunk in stream) {
      final content = chunk.output.content;
      fullResponse += content;
      yield content;
    }

    // 4. Save AI Response
    await _databaseRepository.saveMessage(
      chatId: chatId,
      role: 'ai',
      content: fullResponse,
    );
  }
}
