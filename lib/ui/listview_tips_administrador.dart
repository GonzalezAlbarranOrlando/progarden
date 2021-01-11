import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progarden/firebaseauth/authentication_service.dart';
import 'dart:async';
import 'package:progarden/firebasemodel/tip.dart';
import 'package:progarden/main.dart';
import 'package:progarden/ui/plantas_information.dart';
import 'package:progarden/ui/plantas_screen.dart';
import 'package:progarden/ui/tip_information.dart';
import 'package:progarden/ui/tip_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'menu_page_usuario.dart';

final tipsReference = FirebaseDatabase.instance.reference().child('tip');

class ListViewTipsAdministrador extends StatefulWidget {
  @override
  _ListViewTipsAdministradorState createState() => _ListViewTipsAdministradorState();
}

class _ListViewTipsAdministradorState extends State<ListViewTipsAdministrador> {
  List<Tip> items;
  StreamSubscription<Event> _onTipAddedSubscription;
  StreamSubscription<Event> _onTipChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onTipAddedSubscription =
        tipsReference.onChildAdded.listen(_onTipAdded);
    _onTipChangedSubscription =
        tipsReference.onChildChanged.listen(_onTipUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onTipAddedSubscription.cancel();
    _onTipChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tips',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tips listado'),
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
                                '${items[position].titulo}',
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
                            onPressed: () => _deleteTip(context, items[position], position)),
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

  void _deleteTip(BuildContext context, Tip tip, int position) async {
    await tipsReference.child(tip.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToPlantaInformation(BuildContext context, Tip tip) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TipScreen(tip)),
    );
  }

  void _navigateToPlanta(BuildContext context, Tip tip) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TipInformation(tip)),
    );
  }

  void _onTipAdded(Event event) {
    setState(() {
      items.add(new Tip.fromSnapShop(event.snapshot));
    });
  }

  void _createNewPlanta(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TipScreen(Tip(null, '', ''))),
    );
  }

  void _onTipUpdate(Event event) {
    var oldPlantaValue = items.singleWhere((planta) => planta.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPlantaValue)] =
      new Tip.fromSnapShop(event.snapshot);
    });
  }
}
