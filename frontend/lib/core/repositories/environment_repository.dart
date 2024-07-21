import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentRepository {
  final String _geminiApiKey = 'gemini_api_key';

  String get geminiApiKey => dotenv.env[_geminiApiKey]!;

  Future<void> loadEnvFileData() async {
    await dotenv.load(fileName: ".env");
  }
}
