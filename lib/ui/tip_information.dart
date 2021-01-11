import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progarden/firebasemodel/tip.dart';

final tipReference = FirebaseDatabase.instance.reference().child('tip');

class TipInformation extends StatefulWidget {
  final Tip tip;
  TipInformation(this.tip);
  @override
  _TipInformationState createState() => _TipInformationState();
}

class _TipInformationState extends State<TipInformation> {
  List<Tip> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del tip'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        //height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new Text("[ ${widget.tip.id} ]",
                    style: TextStyle(fontSize: 15.0),),
                  Padding(padding: EdgeInsets.only(top: 10.0),),
                  Divider(),

                  new Text("${widget.tip.titulo}",
                    style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(top: 10.0),),
                  Divider(),

                  new Text("${widget.tip.descripcion}",
                    style: TextStyle(fontSize: 25.0),),
                  Padding(padding: EdgeInsets.only(top: 10.0),),
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