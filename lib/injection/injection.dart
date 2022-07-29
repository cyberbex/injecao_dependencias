import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../manegers/session_manager.dart';

void configureDependencies() {
  final sessionManager = SessionManager();
  debugPrint('inicio da configuracao de dependencias');
  print(sessionManager.hashCode);
  GetIt.I.registerSingleton(sessionManager);
  debugPrint('fim da configuracao de dependencias');
}
