import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Usuario{
  String _id_usuario;
  String _nombre;
  String _apellido_pat;
  String _apellido_mat;
  String _correo;
  String _contrasenia;

  Usuario(this._id_usuario, this._nombre, this._apellido_pat, this._apellido_mat, this._correo, this._contrasenia);

  Usuario.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._apellido_pat = obj['significado'];
    this._apellido_mat = obj['cabeceramun'];
    this._correo = obj['superficie'];
    this._contrasenia = obj['altitud'];
  }

  String get id_igecem => _id_usuario;
  String get nombre =>_nombre;
  String get significado => _apellido_pat;
  String get cabeceramun => _apellido_mat;
  String get superficie => _correo;
  String get altitud => _contrasenia;


  Usuario.fromSnapShop(DataSnapshot snapshot){
    _id_usuario = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _apellido_pat = snapshot.value['apellido_pat'];
    _apellido_mat = snapshot.value['apellido_mat'];
    _correo = snapshot.value['_correo'];
    _contrasenia = snapshot.value['contrasenia'];
  }
}