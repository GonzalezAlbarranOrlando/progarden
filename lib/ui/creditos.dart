import 'package:flutter/material.dart';
import 'package:progarden/firebaseauth/authentication_service.dart';
import 'package:provider/provider.dart';

import 'listview_plantas_usuario.dart';
import 'menu_page_usuario.dart';

class Creditos extends StatelessWidget {
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
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text("INSTITUTO TECNOLÓGICO DE TOLUCA\n"
                "INGENIERÍA EN SISTEMAS COMPUTACIONALES\n"),
          ],
        )),
      ),
    );
  }
}
