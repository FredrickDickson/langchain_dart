import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:arbibot/core/services/langchain_service.dart';

final researchServiceProvider = Provider<ResearchService>((ref) {
  final chatModel = ref.watch(chatModelProvider);
  return ResearchService(chatModel);
});

class ResearchService {
  final ChatOpenAI _chatModel;

  ResearchService(this._chatModel);

  Future<String> performResearch(String query) async {
    final prompt = PromptTemplate.fromTemplate(
      'You are a legal research assistant for Ghanaian law. '
      'Research the following query and provide a summary with citations: {query}'
    );

    final chain = prompt | _chatModel | StringOutputParser();
    final response = await chain.invoke({'query': query});
    return response.toString();
  }
}
