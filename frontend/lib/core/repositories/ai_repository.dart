import 'package:dev_comp_gen_ai_frontend/core/repositories/environment_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiRepository {
  final model = GenerativeModel(
    model:
        'gemini-1.0-pro-001', // gemini-1.5-flash-latest // gemini-1.0-pro-001
    // https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference?hl=de&_gl=1*qi24vq*_ga*Njc0NDczNDQ1LjE3MTQ1MTEyMDE.*_ga_WH2QY8WWF5*MTcyMTU1NDQyNy41Mi4xLjE3MjE1NTU0MDguNTguMC4w
    apiKey: EnvironmentRepository().geminiApiKey,
  );

  Future<String?> analyzeImage() async {
    const prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
//TODO: send image to AI
    return response.text;
  }
}
