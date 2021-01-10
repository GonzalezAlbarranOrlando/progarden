
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_page_usuario.dart';

final reference = FirebaseDatabase.instance.reference();
String temperatura = "";
String humedad_tierra = "";
String humedad = "";
class Sensores_page extends StatefulWidget {
  @override
  _Sensores_pageState createState() => _Sensores_pageState();
}

class _Sensores_pageState extends State<Sensores_page> {

  @override
  void initState() {
    super.initState();
    reference
        .child('sensores')
        .onValue.listen((event) {
      var snapshot = event.snapshot;
      //print(snapshot.value.toString());
      setState(() {
        String value_humedad_tierra = snapshot.value['humedad_tierra'].toString()+"";
        print('Value is $value_humedad_tierra');

        String value_humedad = snapshot.value['humedad'].toString()+"";
        print('Value is $value_humedad');

        String value_temperatura = snapshot.value['temperatura'].toString()+"";
        print('Value is $value_temperatura');

        humedad_tierra = value_humedad_tierra+"";
        humedad = value_humedad+"";
        temperatura = value_temperatura+"";
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sensores'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //context.read<AuthenticationService>().signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Menu_page_usuario()));
            },
          ),
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Container(
                  child:
                  Text("Temperatura: $temperatura °C\n\nHumedad: $humedad %\n\nHumedad tierra: $humedad_tierra%",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}