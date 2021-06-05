import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_poc/views/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppMainActivity());
}

class AppMainActivity extends StatelessWidget {
  AppMainActivity();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map POC',
      home: LoginView(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: const Color(0xFF512DA8)
          ),
          primaryColor: const Color(0xFF673AB7),
          accentColor: const Color(0xFF009688),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: const Color(0xFF009688),
            ),
          ),
          scaffoldBackgroundColor: const Color(0xFFD1C4E9),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                    color: const Color(0xFF009688)
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                    color: const Color(0xFF673AB7)
                ),
              ),
              labelStyle: TextStyle(
                  color: const Color(0xFF009688)
              )
          )
      ),
    );
  }
}
