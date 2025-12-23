import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:arbibot/core/services/langchain_service.dart';

final draftingServiceProvider = Provider<DraftingService>((ref) {
  final chatModel = ref.watch(chatModelProvider);
  return DraftingService(chatModel);
});

class DraftingService {
  final ChatOpenAI _chatModel;

  DraftingService(this._chatModel);

  Future<String> generateDraft({
    required String type,
    required String parties,
    required String facts,
    required String relief,
  }) async {
    final prompt = PromptTemplate.fromTemplate(
      'You are a legal drafting assistant for Ghanaian law. '
      'Draft a {type} based on the following details:\n'
      'Parties: {parties}\n'
      'Facts: {facts}\n'
      'Relief Sought: {relief}\n\n'
      'Ensure the document is professionally formatted and legally sound.'
    );

    final chain = prompt | _chatModel | StringOutputParser();
    final response = await chain.invoke({
      'type': type,
      'parties': parties,
      'facts': facts,
      'relief': relief,
    });
    return response.toString();
  }
}
