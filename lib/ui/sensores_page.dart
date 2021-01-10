import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_page_usuario.dart';

String temperatura = "", humedad = "", humedad_tierra = "";
final reference = FirebaseDatabase.instance.reference();

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

      String value = snapshot.value['temperatura']['Data'];
      print('Value is $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PROGARDEN'),
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

                Container(
                  child:
                  Text("Hola",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ),



              ],
            )),
      ),
    );
  }

}


