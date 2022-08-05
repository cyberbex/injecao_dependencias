import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/models/requisicao.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';

import 'gauge_temp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sessionManager = GetIt.I.get<SessionManager>();
  //final req = GetIt.I.get();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.rqHttp = RequisicaoHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bruno'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Gauge Temperatura'),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const GaugeTemp()));
          },
        ),
      ),
    );
  }
}
