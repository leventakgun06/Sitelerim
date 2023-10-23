import 'package:flutter/material.dart';
import 'package:sitelerim/home/password_list.dart';

import 'constants/app_constants.dart';
import 'home/password_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: textAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      home: const PasswordList(),
      routes: {
        PasswordList.routeName: (context) => const PasswordList(),
        PasswordDetail.routeName: (context) => const PasswordDetail(),
      },
    );
  }
}

