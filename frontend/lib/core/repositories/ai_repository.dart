import 'dart:developer';
import 'dart:typed_data';
import 'package:dev_comp_gen_ai_frontend/core/repositories/environment_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiRepository {
  final model = GenerativeModel(
    model:
        'gemini-1.5-flash-latest', // gemini-1.5-flash-latest // gemini-1.0-pro-001
    // https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference?hl=de&_gl=1*qi24vq*_ga*Njc0NDczNDQ1LjE3MTQ1MTEyMDE.*_ga_WH2QY8WWF5*MTcyMTU1NDQyNy41Mi4xLjE3MjE1NTU0MDguNTguMC4w
    apiKey: EnvironmentRepository().geminiApiKey,
  );

  Future<String?> analyzeImage(Uint8List imageByteList) async {
    // analyze the image with the AI model directly from the app to the AI
    String? response;
    const prompt =
        'Tell me what you see in this picture. Afterwards tell me your suggestions about how to save waste and energy for the things you see in this picture.';
    final content = [
      Content.text(prompt),
      Content.data("image/jpeg", imageByteList)
    ];
    try {
      final modelResponse = await model.generateContent(content);
      response = modelResponse.text;
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
