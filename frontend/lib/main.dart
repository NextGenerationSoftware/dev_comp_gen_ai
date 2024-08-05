import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/environment_repository.dart';
import 'package:dev_comp_gen_ai_frontend/firebase_options.dart';
import 'package:dev_comp_gen_ai_frontend/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvironmentRepository().loadEnvFileData();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables.screenSize = MediaQuery.of(context).size;
    final AppRouter appRouter = AppRouter();

    return GestureDetector(
      onTap: () {
        GlobalFunctions.dismissKeyboard();
      },
      onPanUpdate: (details) {
        GlobalFunctions.dismissKeyboard();
      },
      child: MaterialApp(
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
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: "/",
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
