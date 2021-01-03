import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:progarden/firebasemodel/planta.dart';
import 'package:progarden/main.dart';

final plantaReference = FirebaseDatabase.instance.reference().child('planta');

class PlantaScreen extends StatefulWidget {
  final Planta planta;
  PlantaScreen(this.planta);
  @override
  _PlantaScreenState createState() => _PlantaScreenState();
}

class _PlantaScreenState extends State<PlantaScreen> {
  List<Planta> items;
  TextEditingController _nombreController;
  TextEditingController _descripcionController;
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.planta.nombre);
    _descripcionController = new TextEditingController(text: widget.planta.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Planta'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        //height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(),
                  TextField(
                    controller: _nombreController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.map), labelText: 'Nombre'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _descripcionController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.question_answer),
                        labelText: 'Descripcion'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  FlatButton(
                      onPressed: () {
                        if (widget.planta.id != null) {
                          plantaReference
                              .child(widget.planta.id)
                              .set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {
                          plantaReference.push().set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: (widget.planta.id != null)
                          ? Text('Actualizar')
                          : Text('Agregar')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
