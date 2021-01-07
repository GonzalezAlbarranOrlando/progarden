import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:progarden/firebasemodel/planta.dart';
import 'package:progarden/main.dart';

//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

final plantaReference = FirebaseDatabase.instance.reference().child('planta');
File file_image;
String str_filename;

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

  //nuevo imagen
  String productImage;
  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      file_image = img;
      setState(() {});
    }
  }
  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      file_image = img;
      setState(() {});
    }
  }
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
    _nombreController = new TextEditingController(text: widget.planta.nombre);
    _descripcionController = new TextEditingController(text: widget.planta.descripcion);
    productImage = widget.planta.imagen;
    print(productImage);
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





                  //imagen inicio
                  Row(
                    children: <Widget>[

                      new Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.blueAccent)),
                        padding: new EdgeInsets.all(5.0),
                        child: file_image == null ? Text('Add') : Image.file(file_image),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 2.2),
                        child: new Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Colors.blueAccent)),
                          padding: new EdgeInsets.all(5.0),
                          child: productImage == ''  || productImage == null? Text('Edit') : Image.network(productImage+'?alt=media'),
                        ),
                      ),



                      Divider(),
                      //nuevo para llamar imagen de la galeria o capturarla con la camara
                      new IconButton(
                          icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                      Divider(),
                      new IconButton(
                          icon: new Icon(Icons.image), onPressed: pickerGallery),
                    ],
                  ),
                  //imagen fin





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





                        //nuevo imagen
                        if (widget.planta.id != null) {
                          var now = formatDate(
                              new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                          var fullImageName =
                              '${_nombreController.text}-$now' + '.jpg';
                          var fullImageName2 =
                              '${_nombreController.text}-$now' + '.jpg';

                          //final StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
                          //final StorageUploadTask task = ref.putFile(image);

                          final firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref().child(fullImageName);
                          final firebase_storage.UploadTask task = ref.putFile(file_image);

                          var part1 =
                              //'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/';//esto cambia segun su firestore
                              'https://firebasestorage.googleapis.com/v0/b/progarden-b27e1.appspot.com/o/';

                          var fullPathImage = part1 + fullImageName2;

                          plantaReference.child(widget.planta.id).set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                            'imagen': '$fullPathImage'
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {
                          //nuevo imagen
                          var now = formatDate(
                              new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                          var fullImageName =
                              '${_nombreController.text}-$now' + '.jpg';
                          var fullImageName2 =
                              '${_nombreController.text}-$now' + '.jpg';

                          /*
                          final StorageReference ref =
                          FirebaseStorage.instance.ref().child(fullImageName);
                          final StorageUploadTask task = ref.putFile(image);
*/

                          final firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref().child(fullImageName);
                          final firebase_storage.UploadTask task = ref.putFile(file_image);


                          var part1 =
                              //'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/'; //esto cambia segun su firestore
                              'https://firebasestorage.googleapis.com/v0/b/progarden-b27e1.appspot.com/o/';

                          var fullPathImage = part1 + fullImageName2;
  
                          plantaReference.push().set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                            'imagen':  '$fullPathImage'//nuevo imagen
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
