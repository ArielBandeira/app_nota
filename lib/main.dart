import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController primeiraNotaController = TextEditingController();
  TextEditingController segundaNotaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _refreshFields() {
    primeiraNotaController.text = "";
    segundaNotaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double primeira = double.parse(primeiraNotaController.text);
      double segunda = double.parse(segundaNotaController.text) / 100;

      double mp = (2 * primeira) + (3 * segunda) / 5;    

       if(mp >= 7.0) {
         _infoText = "Aprovado (${mp.toStringAsPrecision(4)})";
       } else if(mp >= 3.0 && mp < 7.0) {
         _infoText = "Avaliação Final (${mp.toStringAsPrecision(4)})";
       } else if(mp < 3.0) {
         _infoText = "Reprovado (${mp.toStringAsPrecision(4)})";
         double af = 3;
         double mf = (mp + af) / 2;
         if(mf >= 5.0){
           _infoText = "Aprovado na AF(${mf.toStringAsPrecision(4)})";
         }
       } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Nota Final"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 50, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.fact_check,
                size: 120.0,
                color: Colors.purple
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "N1",
                  labelStyle: TextStyle(color: Colors.purple)
                ),
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: primeiraNotaController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira sua nota da N1!";
                  }
                  return null;
                },
              ),
              TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        labelText: "N2",
                        labelStyle: TextStyle(color: Colors.purple)),
                    style: TextStyle(color: Colors.purple, fontSize: 25.0),
                    controller: segundaNotaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua nota da N2!";
                      }
                      return null;
                    },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text(
                      "Calcular Média", 
                      style: TextStyle(color: Colors.white, fontSize: 25.0)
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
              )
            ],
          )
        ),
      )
    );
  }
}