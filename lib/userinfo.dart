
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



final CollectionReference UsersRef = Firestore.instance.collection('user');


class UserInfoOnConsole extends StatefulWidget {
  @override
  _UserInfoOnConsoleState createState() => _UserInfoOnConsoleState();
}

class _UserInfoOnConsoleState extends State<UserInfoOnConsole> {

@override
  void initState() {
  getUsers();
  //getUsersById();

  super.initState();
}
//it gives us all the documents inside the collection
//void getUsers() {
//  UsersRef.getDocuments().then((QuerySnapshot snapshot){
//    snapshot.documents.forEach((DocumentSnapshot doc) {
//      print(doc.data);
//      print(doc.documentID);
//    });
//  });
//}
//old way of doing by resolving using then keyword
//void getUsersById(){
//  final String id = 'c2URKGoHdEX1XSDJ3R6S';
//  UsersRef.document(id).get().then((DocumentSnapshot doc) {
//    print(doc.documentID);
//    print(doc.data);
//  });
//}
//new way of doing it by using async and await keyword
//  void getUsersById()async{
//    final String id = 'c2URKGoHdEX1XSDJ3R6S';
//    final DocumentSnapshot doc = await UsersRef.document(id).get();
//      print(doc.documentID);
//      print(doc.data);
//  }

//get the users who have isgraduate  = true

//  getUsers()async{
//    final QuerySnapshot snapshot = await UsersRef.where("isgraduate",isEqualTo: true).getDocuments();
//    snapshot.documents.forEach((DocumentSnapshot doc) {
//      print(doc.data);
//      print(doc.documentID);
//    });
//}


//get the user with xp >2
  getUsers()async{
    final QuerySnapshot snapshot = await UsersRef.getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
      print(doc.documentID);
    });
  }

  //we can use compound query but it will give an erreo we have copy the link from that error
  //and create an index by just visiting to that link.
  //other queries are also there like
  //orderby()
  //limit()


  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
