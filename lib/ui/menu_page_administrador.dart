import 'package:flutter/material.dart';
import 'package:progarden/firebaseauth/authentication_service.dart';
import 'package:progarden/main.dart';
import 'package:progarden/ui/listview_tips_administrador.dart';
import 'package:progarden/ui/sensores_page.dart';
import 'package:provider/provider.dart';

import 'creditos.dart';
import 'listview_plantas_usuario.dart';

class Menu_page_administrador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menú Administrador'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
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
                  //Fluttertoast.showToast(msg: "");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListViewTipsAdministrador()));
                },
                child: Text('Tips'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Creditos()));
                },
                child: Text('Créditos'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
