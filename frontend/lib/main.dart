import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/environment_repository.dart';
import 'package:dev_comp_gen_ai_frontend/pages/ar_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EnvironmentRepository().loadEnvFileData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables.screenSize = MediaQuery.of(context).size;
    final AppRouter appRouter = AppRouter();

    return MaterialApp(
      title: 'Gemini Challenge 2024',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Object Sans",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          surface: GlobalColors.background1,
          background: Colors.white,
        ),
      ),
      home: const Scaffold(body: SafeArea(child: ArPage())),
    );
  }
}
