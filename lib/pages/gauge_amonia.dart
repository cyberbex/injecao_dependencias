import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injecao_de_dependencia/manegers/session_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

class GaugeAmonia extends StatefulWidget {
  const GaugeAmonia({Key? key}) : super(key: key);

  @override
  State<GaugeAmonia> createState() => _GaugeAmoniaState();
}

class _GaugeAmoniaState extends State<GaugeAmonia> {
  final sessionManager = GetIt.I.get<SessionManager>();
  late Timer _timer;

  TextEditingController controllerAmoniaMax = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        sessionManager.rqHttp?.recuperaSensores();
        sessionManager.crtAlarme?.monitoraAlarme();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  salvar() {
    if (controllerAmoniaMax.text != '') {
      sessionManager.crtAlarme?.amoniaMaxAlarme = controllerAmoniaMax.text;
      controllerAmoniaMax.text = '';
    }
  }

  showAlertDialog(BuildContext context) {
    Widget cancelaButton = ElevatedButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = ElevatedButton(
      child: const Text("Salvar"),
      onPressed: () {
        Navigator.of(context).pop();
        salvar();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Tem certeza que deseja alterar valor de Alarme?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _amoniaGauge(double amonia) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 280,
            height: 290,
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 1000,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 60,
                  interval: 5,
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        value: amonia.toDouble(), enableAnimation: true),
                  ],
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 5,
                        color: Colors.blue.shade100),
                    GaugeRange(
                        startValue: 5, endValue: 10, color: Colors.red.shade50),
                    GaugeRange(
                        startValue: 10,
                        endValue: 20,
                        color: Colors.red.shade100),
                    GaugeRange(
                        startValue: 20,
                        endValue: 30,
                        color: Colors.red.shade200),
                    GaugeRange(
                        startValue: 30,
                        endValue: 60,
                        color: Colors.red.shade300)
                  ],
                  // ignore: prefer_const_literals_to_create_immutables
                  annotations: <GaugeAnnotation>[
                    const GaugeAnnotation(
                      widget: Text('Amônia',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      positionFactor: 0.5,
                      angle: 90,
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Amonia'),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            _amoniaGauge(sessionManager.rqHttp?.amonia),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                const Text(
                  "Alarme amônia máxima:",
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
                Text(
                  '${sessionManager.crtAlarme!.amoniaMaxAlarme} ppm',
                  style: const TextStyle(
                      fontSize: 22, backgroundColor: Colors.amber),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              controller: controllerAmoniaMax,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Digite um novo valor para alarme"),
            ),
            ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Text('Salvar'))
          ],
        )),
      ),
    );
  }
}
