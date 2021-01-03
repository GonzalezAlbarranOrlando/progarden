import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progarden/firebasemodel/planta.dart';

final municipioReference = FirebaseDatabase.instance.reference().child('planta');

class PlantaInformation extends StatefulWidget {
  final Planta planta;
  PlantaInformation(this.planta);
  @override
  _PlantaInformationState createState() => _PlantaInformationState();
}

class _PlantaInformationState extends State<PlantaInformation> {
  List<Planta> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del planta'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        //height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  new Text("ID : ${widget.planta.id}",
                    style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Nombre : ${widget.planta.nombre}",
                    style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Descripcion : ${widget.planta.descripcion}",
                    style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}