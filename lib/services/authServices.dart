import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final usersRef = FirebaseFirestore.instance.collection("users");

class AuthServices {
  final _auth = FirebaseAuth.instance;
  String firebaseError = "";

  createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required Function() pushNewScreen}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value == null) {
          return;
        } else {
         try{ createUserInFirestore(
             firstName: firstName, lastName: lastName, email: email).then((value){
           if(value!=null){
             pushNewScreen;
           }
         });}on FirebaseException catch(e){
           Fluttertoast.showToast(
               msg: e.message!,
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIosWeb: 2,
               backgroundColor: Colors.red,
               textColor: Colors.white,
               fontSize: 16.0);
         }
        }
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    ;

    //Store user details in firestore
  }

  loginUserWithEmailAndPassword({required String email,
    required String password,})async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        if(value==null){
          return;
        }
      });
    }on FirebaseAuthException catch(e){
      return Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  resetPasswordWithEmail({required String email,
    })async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      return Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  createUserInFirestore({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      final User? user = _auth.currentUser;
      usersRef.doc(user!.uid).set({
        "id": user.uid,
        "email": user.email,
        "timestamp": Timestamp.now(),
        "firstname": firstName,
        "lastname": lastName,
        "profileURL": null,
      });
    } catch (e) {
      print("error creating user in firestore $e");
    }
  }
}
