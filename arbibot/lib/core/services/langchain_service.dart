import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_openai/langchain_openai.dart';

final langchainServiceProvider = Provider<LangChainService>((ref) {
  return LangChainService();
});

final chatModelProvider = Provider<ChatOpenAI>((ref) {
  final apiKey = dotenv.env['OPENAI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('OPENAI_API_KEY not found in .env');
  }
  return ChatOpenAI(apiKey: apiKey);
});

class LangChainService {
  // Placeholder for future LangChain specific configurations
}
