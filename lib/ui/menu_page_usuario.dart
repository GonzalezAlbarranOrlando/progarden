import 'package:flutter/material.dart';
import 'package:progarden/firebaseauth/authentication_service.dart';
import 'package:progarden/main.dart';
import 'package:progarden/ui/sensores_page.dart';
import 'package:provider/provider.dart';

import 'creditos.dart';
import 'listview_plantas_usuario.dart';

class Menu_page_usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menú Usuario'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              }
              //onPressed: () => _createNewMunicipio(context),
              ),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            new SizedBox(
              width: 200.0,
              child: new RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewPlantaUsuario()));
                },
                child: Text('Lista de plantas'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            new SizedBox(
              width: 200.0,
              child: new RaisedButton(
                onPressed: () {
                  //Fluttertoast.showToast(msg: "");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Sensores_page()));
                },
                child: Text('Sensores'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            new SizedBox(
              width: 200.0,
              child: new RaisedButton(
                onPressed: () {
                  //Fluttertoast.showToast(msg: "");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Creditos()));
                },
                child: Text('Creditos'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
