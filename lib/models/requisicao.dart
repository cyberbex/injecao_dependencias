import 'package:http/http.dart' as http;
import 'dart:convert';

class RequisicaoHttp {
  
  dynamic amonia = 0.0;
  dynamic humidade = 0.0;
  dynamic temperatura = 0;

  recuperaSensores() async {
    String url = "http://15.228.187.254:5000/valores";
    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    amonia = retorno['amonia'];
    humidade = retorno['humidade'];
    temperatura = retorno['temperatura'];

    print("temperatura: $temperatura amonia: $amonia humidade $humidade");

    //print("resposta" + response.body);
  }
}
