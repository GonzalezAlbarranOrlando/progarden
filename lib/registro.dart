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
  String str_nombre = "",
      str_apellido_pat = "",
      str_apellido_mat = "",
      str_correo = "",
      str_contrasenia = "",
      str_conf_contrasenia = "";
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
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nombreController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Nombre"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: apellido_patController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Apellido Paterno"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: apellido_matController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Apellido Materno"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Correo"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: contraseniaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Contraseña"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        } else if (!(text.length > 5)) {
                          return 'La contraseña debe contener más de 5 caracteres';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: conf_contraseniaController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Confirmar contraseña"),
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        } else if (!(text.length > 5)) {
                          return 'La contraseña debe contener más de 5 caracteres';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (!_formkey.currentState.validate()) {
                          return;
                        }
                        str_nombre = nombreController.text.trim();
                        str_apellido_pat = apellido_patController.text.trim();
                        str_apellido_mat = apellido_matController.text.trim();
                        str_correo = correoController.text.trim();
                        str_contrasenia = contraseniaController.text.trim();
                        str_conf_contrasenia =
                            conf_contraseniaController.text.trim();
                        if (!validacion()) {
                          return;
                        }
                        context.read<AuthenticationService>().createUser(
                            nombre: str_nombre,
                            apellido_pat: str_apellido_pat,
                            apellido_mat: str_apellido_mat,
                            email: str_correo,
                            password: str_contrasenia);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
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
          )),
    );
  }

  bool validacion() {
    if (str_contrasenia != str_conf_contrasenia) {
      Fluttertoast.showToast(msg: "Las contraseñas no coinciden");
      return false;
    }
    return true;
  }
}
