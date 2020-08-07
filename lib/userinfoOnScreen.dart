import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference userRef =  Firestore.instance.collection('user');

class UserInfoOnScreen extends StatefulWidget {
  @override
  _UserInfoOnScreenState createState() => _UserInfoOnScreenState();
}

//Direct method no future builder is used

//class _UserInfoOnScreenState extends State<UserInfoOnScreen> {
//  //create a list to store the doc we get
//  List <dynamic> users= [];
//  @override
//  void initState() {
//    getUser();
//    super.initState();
//  }
//
//  getUser() async{
//    final QuerySnapshot snapshot =await userRef.getDocuments();
//
//    setState(() {
//      users = snapshot.documents;
//    });
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: ListView(children: users.map((User)=>
//        Column(
//          children: [
//            Text(User['name']),
//            Text(User['profession'])
//          ],
//
//        )
//      ).toList(),)
//    );
//  }
//}


//By using Future Builder

class _UserInfoOnScreenState extends State<UserInfoOnScreen> {
  //create a list to store the doc we get
  @override
  void initState() {
    super.initState();
    CreateUser();
  }
CreateUser(){
    userRef.add({
      "username":"gothi",

    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future:userRef.getDocuments(),
        builder: (context, snapshot){
          //it means our future is not resolved yet.
          if (!snapshot.hasData){
            return Text('loading...');

          }
          return Container(
        child: ListView(children: snapshot.data.documents.map((User)=>
          Column(
            children: [
              Text(User['username']),
      //        Text(User['profession'])
          ],

        )
      ).toList(),)
    );
        } ,
      ),
    );
  }
}
