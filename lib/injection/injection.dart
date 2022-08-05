import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/manegers/requisicao.dart';
import '../manegers/session_manager.dart';

void configureDependencies() {
  final sessionManager = SessionManager();
  debugPrint('inicio da configuracao de dependencias');
  print(sessionManager.hashCode);

  GetIt.I.registerSingleton(sessionManager);
  //GetIt.I.registerSingleton(RequisicaoHttp());

  debugPrint('fim da configuracao de dependencias');
}
