import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Planta{
  String _id;
  String _nombre;
  String _descripcion;
  String _id_usuario;
  String _imagen;

  Planta(this._id, this._nombre, this._descripcion, this._id_usuario, this._imagen);

  Planta.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._descripcion = obj['descripcion'];
    this._id_usuario = obj['id_usuario'];
    this._imagen = obj['imagen'];
  }

  String get id => _id;
  String get nombre =>_nombre;
  String get descripcion => _descripcion;
  String get id_usuario => _id_usuario;
  String get imagen => _imagen;

  Planta.fromSnapShop(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _descripcion = snapshot.value['descripcion'];
    _id_usuario = snapshot.value['id_usuario'];
    _imagen = snapshot.value['imagen'];
  }
}