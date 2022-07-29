import 'package:flutter/material.dart';
import 'package:injecao_de_dependencia/injection/injection.dart';
import 'package:injecao_de_dependencia/pages/login_page.dart';

void main() {
  configureDependencies();
  runApp(
    const MaterialApp(
      title: 'Flutter Injector',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}
