import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/manegers/requisicao.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';

import '../models/user.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final sessionManager = GetIt.I.get<SessionManager>();
  //final req = GetIt.I.get();
  String ch = 'bruno';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sessionManager.user?.name ?? 'bruno'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('click'),
          onPressed: () {
            //sessionManager.recupera_sensores();
            //req.escreve();
            //print(sessionManager.user!.name);
            sessionManager.rqHttp = RequisicaoHttp();
            sessionManager.rqHttp?.recuperaSensores();

            sessionManager.user = User("Bruno Migliorini");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const HomePage()));
          },
        ),
      ),
    );
  }
}
