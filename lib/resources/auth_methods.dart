// ignore_for_file: unused_import

import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Getting current user
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // ignore: avoid_print
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage(
          'profile',
          file,
          false,
        );

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        //add user details to firestore database
        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);

        res = "Success";
      }
    }on FirebaseAuthException catch(err){
      if(err.code == 'weak-password'){
        res = 'The password provided is too weak.';
      } else if(err.code == 'email-already-in-use'){
        res = 'The account already exists for that email.';
      } else if(err.code == 'invalid-email'){
        res = 'The email address is not valid.';
      }else if(err.code == 'operation-not-allowed'){
        res = 'The email/password accounts are not enabled.';
      }else if(err.code == 'too-many-requests'){
        res = 'Too many requests to log into this account.';
      }else if(err.code == 'user-not-found'){
        res = 'No user found for that email.';
      }else if(err.code == 'wrong-password'){
        res = 'Wrong password provided for that user.';
      } else{
        res = err.toString();
      }
    } 
    
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async{
    String res = "Some Error Occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
         await _auth.signInWithEmailAndPassword(
          email: email, password: password);
        res = "Success";
      }else{
          res = "Please enter email and password";
      }
    } on FirebaseAuthException catch(err){
      if(err.code == 'wrong-password'){
        res = 'The password provided is wrong.';
      } else if(err.code == 'user-not-found'){
        res = 'The account you are trying to reach does not exist.';
      }else{
        res = err.toString();
      }
    }
      catch(err){
        res = err.toString();
      }
      return res;
  }
}
