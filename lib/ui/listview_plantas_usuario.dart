import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progarden/firebaseauth/authentication_service.dart';
import 'dart:async';
import 'package:progarden/firebasemodel/planta.dart';
import 'package:progarden/main.dart';
import 'package:progarden/ui/plantas_information.dart';
import 'package:progarden/ui/plantas_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'menu_page_usuario.dart';

final plantaReference = FirebaseDatabase.instance.reference().child('planta');

class ListViewPlantaUsuario extends StatefulWidget {
  @override
  _ListViewPlantaUsuarioState createState() => _ListViewPlantaUsuarioState();
}

class _ListViewPlantaUsuarioState extends State<ListViewPlantaUsuario> {
  List<Planta> items;
  StreamSubscription<Event> _onPlantaAddedSubscription;
  StreamSubscription<Event> _onPlantaChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onPlantaAddedSubscription =
        plantaReference.onChildAdded.listen(_onPlantaAdded);
    _onPlantaChangedSubscription =
        plantaReference.onChildChanged.listen(_onPlantaUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onPlantaAddedSubscription.cancel();
    _onPlantaChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de plantas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plantas listado'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //context.read<AuthenticationService>().signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Menu_page_usuario()));
            },
          ),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 12.0),
              itemBuilder: (context, position) {
                if (items[position].id_usuario == id_firebaseAuth) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 7.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                              title: Text(
                                '${items[position].nombre}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                ),
                              ),
                              subtitle: Text(
                                '${items[position].descripcion}',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 13.0,
                                ),
                              ),
                              leading: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.cyan,
                                    radius: 17.0,
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () => _navigateToPlanta(
                                  context, items[position])),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => _deletePlanta(context, items[position], position)),
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.greenAccent,
                            ),
                            onPressed: () => _navigateToPlantaInformation(
                                context, items[position])),
                      ],
                    ),
                  ],
                );
                }else{
                  return Column();
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.amber,
          onPressed: () => _createNewPlanta(context),
        ),
      ),
    );
  }

  void _deletePlanta(BuildContext context, Planta planta, int position) async {
    await plantaReference.child(planta.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToPlantaInformation(BuildContext context, Planta planta) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlantaScreen(planta)),
    );
  }

  void _navigateToPlanta(BuildContext context, Planta planta) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlantaInformation(planta)),
    );
  }

  void _onPlantaAdded(Event event) {
    setState(() {
      items.add(new Planta.fromSnapShop(event.snapshot));
    });
  }

  void _createNewPlanta(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PlantaScreen(Planta(null, '', '',''))),
    );
  }

  void _onPlantaUpdate(Event event) {
    var oldPlantaValue = items.singleWhere((planta) => planta.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPlantaValue)] =
      new Planta.fromSnapShop(event.snapshot);
    });
  }
}
