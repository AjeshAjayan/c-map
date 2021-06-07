import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_poc/views/infrasturcture_list.dart';
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
              color: const Color(0xFF31942b)
          ),
          primaryColor: const Color(0xFF31942b),
          accentColor: const Color(0xFF31942b),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: const Color(0xFF31942b),
            ),
          ),
          scaffoldBackgroundColor: const Color(0xFFd7d7d9),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                    color: const Color(0xFF31942b)
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                    color: const Color(0xFF31942b)
                ),
              ),
              labelStyle: TextStyle(
                  color: const Color(0xFF31942b)
              )
          )
      ),
    );
  }
}
