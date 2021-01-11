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
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Menu_page_usuario()));
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[


                Image.asset(
                  'images/progarden.png',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),

                Container(
                  child:
                  Text("INSTITUTO TECNOLÓGICO DE TOLUCA\n\n"
                      "INGENIERÍA EN SISTEMAS COMPUTACIONALES\n\n"
                      "PROGRAMACIÓN AVANZADA PARA EL DESARROLLODE APLICACIONES MÓVILES\n\n"
                      "-GARCÍA SAAVEDRA AMÉRICA LUCERO\n"
                      "-GONZÁLEZ ALBARRÁN ORLANDO\n"
                      "-GONZÁLEZ VALLEJO ARIANA JAQUELIN\n\n"
                      "Versión 1.0\n\n"
                      "DOCENTE:  PULIDO ROCÍO ELIZABETH\n\n",
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
