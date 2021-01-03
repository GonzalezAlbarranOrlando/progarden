import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progarden/main.dart';
import 'package:provider/provider.dart';

import 'firebaseauth/authentication_service.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreen createState() => _RegistroScreen();
}

class _RegistroScreen extends State<RegistroScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellido_patController = TextEditingController();
  final TextEditingController apellido_matController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();
  final TextEditingController conf_contraseniaController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Registro'),
            centerTitle: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nombreController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Nombre"),
                      ),
                      TextFormField(
                        controller: apellido_patController,
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: "Apellido Paterno"),
                      ),
                      TextFormField(
                        controller: apellido_matController,
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: "Apellido Materno"),
                      ),
                      TextFormField(
                        controller: correoController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Correo"),
                      ),
                      TextFormField(
                        controller: contraseniaController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Contraseña"),
                        obscureText: true,
                      ),
                      TextFormField(
                        controller: conf_contraseniaController,
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: "Confirmar contraseña"),
                        obscureText: true,
                      ),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().createUser(
                              nombre: nombreController.text.trim(),
                              apellido_pat: apellido_patController.text.trim(),
                              apellido_mat: apellido_matController.text.trim(),
                              email: correoController.text.trim(),
                              password: contraseniaController.text.trim());
                        },
                        child: Text('Registrarse'),
                        color: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "¿Ya tienes cuenta?",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                //Navigator.of(context).pop(main());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              },
                              child: Text(
                                "Ingresar",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.orange[200],
                                    fontSize: 19),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
