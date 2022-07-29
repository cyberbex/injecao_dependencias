import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../manegers/session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sessionManager = GetIt.I.get<SessionManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sessionManager.user?.name ?? 'nao logado'),
      ),
    );
  }
}
