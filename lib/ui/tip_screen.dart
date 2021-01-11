import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progarden/firebasemodel/tip.dart';
import 'package:progarden/main.dart';

final tipReference = FirebaseDatabase.instance.reference().child('tip');

class TipScreen extends StatefulWidget {
  final Tip tip;
  TipScreen(this.tip);
  @override
  _TipScreenState createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {

  List<Tip> items;
  TextEditingController _tituloController;
  TextEditingController _descripcionController;
  final _formKey = new GlobalKey<FormState>();


  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tituloController = new TextEditingController(text: widget.tip.titulo);
    _descripcionController = new TextEditingController(text: widget.tip.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Tip'),
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
                  TextFormField(
                    controller: _tituloController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.map), labelText: 'Titulo'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _descripcionController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.question_answer),
                        labelText: 'Descripcion'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  FlatButton(
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        if (widget.tip.id != null) {
                          tipReference.child(widget.tip.id).set({
                            'titulo': _tituloController.text,
                            'descripcion': _descripcionController.text,
                          }).then((_) {
                            //Navigator.pop(context);
                          });
                        } else {
                          tipReference.push().set({
                            'titulo': _tituloController.text,
                            'descripcion': _descripcionController.text,
                          }).then((_) {
                            //Navigator.pop(context);
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: (widget.tip.id != null)
                          ? Text('Actualizar')
                          : Text('Agregar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
