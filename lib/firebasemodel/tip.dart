import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Tip{
  String _id;
  String _titulo;
  String _descripcion;

  Tip(this._id, this._titulo, this._descripcion);

  Tip.map(dynamic obj){
    this._titulo = obj['titulo'];
    this._descripcion = obj['descripcion'];
  }

  String get id => _id;
  String get titulo =>_titulo;
  String get descripcion => _descripcion;

  Tip.fromSnapShop(DataSnapshot snapshot){
    _id = snapshot.key;
    _titulo = snapshot.value['titulo'];
    _descripcion = snapshot.value['descripcion'];
  }
}