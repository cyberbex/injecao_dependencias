import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/models/controle_alarme.dart';
import 'package:injecao_de_dependencia/models/requisicao.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';
import 'package:injecao_de_dependencia/pages/gauge_amonia.dart';

import 'gauge_temp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sessionManager = GetIt.I.get<SessionManager>();
  int paginaAtual = 0;
  late PageController pc;

  //final req = GetIt.I.get();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.rqHttp = RequisicaoHttp();
    sessionManager.crtAlarme = ControleAlarme();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: const [
          GaugeTemp(),
          GaugeAmonia(),
        ],
      ),
    );
  }
}
