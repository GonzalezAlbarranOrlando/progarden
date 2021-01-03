import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';

class AuthenticationService{

  final databaseReference = FirebaseDatabase.instance.reference();

  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    id_firebaseAuth = "";
    correo_firebaseAuth = "";
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      id_firebaseAuth = _firebaseAuth.currentUser.uid;
      correo_firebaseAuth = email;
      return "Sign In";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> createUser({String nombre, String apellido_pat,String apellido_mat, String email, String password}) async{
    try{
      //crear el usuario para el acceso
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      //crear el registro del usuario para realtime database
      databaseReference.child("usuario").child(_firebaseAuth.currentUser.uid).set({
        'nombre': nombre,
        'apellido_pat': apellido_pat,
        'apellido_mat': apellido_mat,
        'correo': email,
        'contrasenia': password
      });
      //borrar sesion
      await _firebaseAuth.signOut();
      //retornar
      return "Sign Up";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  String get_email() {
    return _firebaseAuth.currentUser.email;
  }
}