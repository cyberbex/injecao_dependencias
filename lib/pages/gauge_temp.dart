import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../manegers/session_manager.dart';

class GaugeTemp extends StatefulWidget {
  const GaugeTemp({Key? key}) : super(key: key);

  @override
  State<GaugeTemp> createState() => _GaugeTempState();
}

class _GaugeTempState extends State<GaugeTemp> {
  final sessionManager = GetIt.I.get<SessionManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dsf'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              sessionManager.rqHttp?.recuperaSensores();
            },
            child: const Text('click')),
      ),
    );
  }
}
