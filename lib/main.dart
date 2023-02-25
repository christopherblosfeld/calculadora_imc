import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _textoinfo = 'Informe os dados para calcular.';
  final _formKey = GlobalKey<FormState>();
  final _pesoKey = GlobalKey<FormFieldState>();
  final _alturaKey = GlobalKey<FormFieldState>();

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    _textoinfo = 'Informe os dados para calcular.';
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      print(imc);

      if (imc < 18.6) {
        _textoinfo = 'Abaixo do Peso, IMC: ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 18.6 && imc < 24.9) {
        _textoinfo = 'Peso ideal, IMC: ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 24.9 && imc < 29.9) {
        _textoinfo =
            'Levemente acima do peso, IMC: ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 29.9 && imc < 34.9) {
        _textoinfo = 'Obesidade grau I, IMC: ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 34.9 && imc < 39.9) {
        _textoinfo = 'Obesidade grau II, IMC: ${imc.toStringAsPrecision(3)}';
      } else if (imc >= 40) {
        _textoinfo =
            'Obesidade grau III, c vai morrer !! IMC: ${imc.toStringAsPrecision(3)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Calculadora de IMC'),
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _resetFields();
                  });
                },
              )
            ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              child: Column(
                  key: _formKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.person_outline,
                        size: 120, color: Colors.green),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      key: _pesoKey,
                      validator: _validaPeso,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Peso (kg)',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.green, fontSize: 25),
                      controller: weightController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: _alturaKey,
                      validator: _validaAltura,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Altura (cm)',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.green, fontSize: 25),
                      controller: heightController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green), //Cor verde do botao
                        onPressed: () {
                          if (_pesoKey.currentState?.validate() == false ||
                              _alturaKey.currentState?.validate() == false) {
                            return;
                          }
                          _calculate();
                        },

                        child: const Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      _textoinfo,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                  ]),
            )));
  }
}

String? _validaPeso(String? peso) {
  if (peso == null || peso.isEmpty) {
    return 'Informe um peso!';
  }
}

String? _validaAltura(String? altura) {
  if (altura == null || altura.isEmpty) {
    return 'Informe uma altura!';
  }
}
