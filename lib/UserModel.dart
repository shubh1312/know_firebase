import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class User {
  final String id;
  final String photoUrl;
  final String username;
  final String displayName;
  final String bio;
  final String email;

  User({
    this.displayName,
    this.photoUrl,
    this.email,
    this.bio,
    this.id,
    this.username,
});


  factory User.fromDocument(DocumentSnapshot doc){
   return User(
     bio: doc['bio'],
     displayName: doc['displayname'],
     email: doc['email'],
     id: doc['id'],
     photoUrl: doc['photo url'],
     username: doc['username']

   ) ;
  }
}