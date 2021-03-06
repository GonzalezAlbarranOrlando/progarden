import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progarden/registro.dart';
import 'package:progarden/ui/menu_page_administrador.dart';
import 'package:progarden/ui/menu_page_usuario.dart';
import 'package:provider/provider.dart';

import 'firebaseauth/authentication_service.dart';

String correo_firebaseAuth = "";
String id_firebaseAuth = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if (firebaseuser != null) {
      if (correo_firebaseAuth == "administrador@gmail.com") {
        Fluttertoast.showToast(msg: "Bienvenido administrador");
        return Menu_page_administrador();
      } else if (correo_firebaseAuth != "") {
        Fluttertoast.showToast(msg: "Bienvenido usuario " + firebaseuser.uid);
        return Menu_page_usuario();
      }
    }
    return Login_page();
  }
}

class Login_page extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ingresar'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Form(
            key: _formkey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Correo electrónico"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Contraseña"),
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
                        if (_formkey.currentState.validate()) {
                          context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                          if (correo_firebaseAuth == "administrador@gmail.com") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Menu_page_administrador()));
                          } else if (correo_firebaseAuth != "") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Menu_page_usuario()));
                            return Menu_page_usuario();
                          }
                        }
                      },
                      child: Text('Ingresar'),
                      color: Colors.deepOrangeAccent,
                      textColor: Colors.white,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "¿No tienes cuenta?",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              //Navigator.of(context).pop(main());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroScreen()));
                            },
                            child: Text(
                              "Registrarse",
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
                ))),
      ),
    );
  }
}
