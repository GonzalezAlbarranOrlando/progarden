import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    _descripcionController =
        new TextEditingController(text: widget.planta.descripcion);
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
                  //imagen row inicio
                  Row(
                    children: <Widget>[
                      Divider(),
                      new IconButton(
                          icon: new Icon(Icons.camera_alt),
                          onPressed: pickerCam),
                      /*
                      Divider(),
                      new IconButton(
                          icon: new Icon(Icons.image), onPressed: pickerGallery),
                       */
                      new Container(
                        height: 150.0,
                        width: 120.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.grey)),
                        padding: new EdgeInsets.all(5.0),
                        child: file_image == null
                            ? Text('Add')
                            : Image.file(
                                file_image,
                                height: 200,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.2),
                        child: new Container(
                          height: 150.0,
                          width: 120.0,
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Colors.white)),
                          padding: new EdgeInsets.all(5.0),
                          child: productImage == '' || productImage == null
                              ? Text('')
                              : Image.network(
                                  productImage + '?alt=media',
                                  height: 200,
                                ),
                        ),
                      ),
                    ],
                  ),
                  //imagen row fin

                  Divider(),
                  TextFormField(
                    controller: _nombreController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.map), labelText: 'Nombre'),
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

                        //nuevo imagen
                        if (widget.planta.id != null) {
                          var now = formatDate(new DateTime.now(), [
                            yyyy, '-', mm, '-', dd, '_', HH, '-', mm, '-', ss
                          ]);
                          var fullImageName =
                              '${_nombreController.text}_$now' + '.jpg';
                          var fullImageName2 =
                              '${_nombreController.text}_$now' + '.jpg';

                          //final StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
                          //final StorageUploadTask task = ref.putFile(image);

                          if(file_image!=null){
                          final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fullImageName);
                          final firebase_storage.UploadTask task = ref.putFile(file_image);
                          }
                          var part1 =
                              //'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/';//esto cambia segun su firestore
                              'https://firebasestorage.googleapis.com/v0/b/progarden-b27e1.appspot.com/o/';

                          var fullPathImage;

                          if(file_image==null){
                            fullPathImage = productImage;
                          }else{
                            fullPathImage = part1 + fullImageName2;
                          }

                          plantaReference.child(widget.planta.id).set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                            'imagen': '$fullPathImage'
                          }).then((_) {
                            file_image = null;
                            Navigator.pop(context);
                          });
                        } else {
                          //nuevo imagen
                          var now = formatDate(new DateTime.now(), [
                            yyyy, '-', mm, '-', dd, '_', HH, '-', mm, '-', ss
                          ]);
                          var fullImageName =
                              '${_nombreController.text}_$now' + '.jpg';
                          var fullImageName2 =
                              '${_nombreController.text}_$now' + '.jpg';

                          //final StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
                          //final StorageUploadTask task = ref.putFile(image);
                          if(file_image==null){
                            Fluttertoast.showToast(msg: "Se requiere la imagen");
                            return;
                          }
                          final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fullImageName);
                          final firebase_storage.UploadTask task = ref.putFile(file_image);

                          var part1 =
                              //'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/'; //esto cambia segun su firestore
                              'https://firebasestorage.googleapis.com/v0/b/progarden-b27e1.appspot.com/o/';

                          var fullPathImage = part1 + fullImageName2;

                          plantaReference.push().set({
                            'nombre': _nombreController.text,
                            'descripcion': _descripcionController.text,
                            'id_usuario': id_firebaseAuth,
                            'imagen': '$fullPathImage' //nuevo imagen
                          }).then((_) {
                            file_image = null;
                            Navigator.pop(context);
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: (widget.planta.id != null)
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
