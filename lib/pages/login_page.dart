import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';
import 'package:injecao_de_dependencia/models/user.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final sessionManager = GetIt.I.get<SessionManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Entrar'),
          onPressed: () {
            print(sessionManager.hashCode);
            sessionManager.user = User("Bruno Migliorini");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const HomePage()));
          },
        ),
      ),
    );
  }
}
