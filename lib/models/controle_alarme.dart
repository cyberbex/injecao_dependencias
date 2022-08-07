import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';

class ControleAlarme {
  final sessionManager = GetIt.I.get<SessionManager>();

  String tempMaxAlarme = '30';
  String tempMinAlarme = '2';
  String amoniaMaxAlarme = '2';

  monitoraAlarme() {
    double tempMax = double.parse(tempMaxAlarme);
    double tempMin = double.parse(tempMinAlarme);
    double amoniaMax = double.parse(amoniaMaxAlarme);
    //

    if (sessionManager.rqHttp?.temperatura > tempMax) {
      //playMusic();
      print('temp alta!!');
    } else if (sessionManager.rqHttp?.temperatura < tempMin) {
      //playMusic();
      print('temp baixa');
    } else if (sessionManager.rqHttp?.amonia > amoniaMax) {
      print('amonia alta');
    }
  }
}
