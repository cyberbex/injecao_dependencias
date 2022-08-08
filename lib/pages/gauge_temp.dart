import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

import '../manegers/session_manager.dart';

class GaugeTemp extends StatefulWidget {
  const GaugeTemp({Key? key}) : super(key: key);

  @override
  State<GaugeTemp> createState() => _GaugeTempState();
}

class _GaugeTempState extends State<GaugeTemp> {
  final sessionManager = GetIt.I.get<SessionManager>();
  late Timer _timer;
  TextEditingController tempMaxEditingController = TextEditingController();
  TextEditingController tempMinEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();

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
    if (tempMaxEditingController.text != '') {
      sessionManager.crtAlarme?.tempMaxAlarme = tempMaxEditingController.text;
      tempMaxEditingController.text = '';
    }
    if (tempMinEditingController.text != '') {
      sessionManager.crtAlarme?.tempMinAlarme = tempMinEditingController.text;
      tempMinEditingController.text = '';
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

  Widget _tempGauge(dynamic temperatura) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 290,
            height: 270,
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 1000,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 35,
                  interval: 2,
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        value: temperatura.toDouble(), enableAnimation: true),
                  ],
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0, endValue: 20, color: Colors.green),
                    GaugeRange(
                        startValue: 20, endValue: 28, color: Colors.yellow),
                    GaugeRange(startValue: 28, endValue: 40, color: Colors.red)
                  ],
                  annotations: const <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        'Temperatura',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
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
        title: const Text('Sensor Temperatura'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              _tempGauge(sessionManager.rqHttp?.temperatura),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Form(
                    child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        //alignment: Alignment.center,
                        decoration:
                            BoxDecoration(color: Colors.blue.withOpacity(0.1)),
                        child: Text(
                          'Alarme Temp Max ${sessionManager.crtAlarme?.tempMaxAlarme} graus',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    TextFormField(
                      key: _form,
                      controller: tempMaxEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Digite Máxima alarme",
                        prefixIcon: Icon(Icons.access_alarm),
                        suffix: Text(
                          'graus',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um valor de temperatura minima entre 0 e 40';
                        } else if (double.parse(value) >= 0 &&
                            double.parse(value) <= 40) {
                          return 'valor fora de range!!';
                        }
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        //alignment: Alignment.center,
                        decoration:
                            BoxDecoration(color: Colors.blue.withOpacity(0.1)),
                        child: Text(
                          'Alarme Temp Min ${sessionManager.crtAlarme?.tempMinAlarme} graus',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    TextFormField(
                      controller: tempMinEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Digite Minima alarme",
                        prefixIcon: Icon(Icons.access_alarm),
                        suffix: Text(
                          'graus',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um valor de temperatura máxima entre 0 e 40';
                        } else if (double.parse(value) >= 0 &&
                            double.parse(value) <= 40) {
                          return 'valor fora de range!!';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
