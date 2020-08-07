import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseknow/UserModel.dart';
import 'package:firebaseknow/createUserPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'userinfo.dart';
import 'package:firebaseknow/userinfoOnScreen.dart';

final GoogleSignIn googleSignin = GoogleSignIn();
final DateTime timestamp = DateTime.now();
User currentUser;

final CollectionReference userRef = Firestore.instance.collection('user');

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isauth = false;
  @override


  void initState(){
    super.initState();
    googleSignin.onCurrentUserChanged.listen((account) {
      handelSignin(account);
    },
    onError: (err){
      print("Error sigining in $err");
    });
    googleSignin.signInSilently(suppressErrors: false).then((account){
        handelSignin(account);
    } );
  }

  createUserEntry() async {
    //1 check if user exist in user collection inside the database
    final GoogleSignInAccount user = googleSignin.currentUser;
    DocumentSnapshot doc = await userRef.document(user.id).get();
    //2 If the user doesnt exist than we want to take them to create account page.
    if (!doc.exists){
        final username  = await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return
             CreateUserPage();
          },
        ));
        //3 create a new documnet in the collection by using the username provided by the user
        userRef.document(user.id).setData({
          "id": user.id,
          "username" : username,
          "email" : user.email,
          "photo url" : user.photoUrl,
          "displayname" : user.displayName,
          "bio" : "",
          "timestamp": timestamp,
        });
        doc = await userRef.document(user.id).get();
    }

     currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.displayName);
  }

  handelSignin(GoogleSignInAccount account){
    if (account !=null){
      createUserEntry();
      print("account logged in $account");
      setState(() {
        isauth = true;
      });
    }
    else{
      setState(() {
        print("failed to login !!!!!!!!!");
        isauth = false;
      });
    }
  }

  Login(){
      googleSignin.signIn();
  }
  Logout(){
    googleSignin.signOut();
  }

  Widget AuthencatedScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text("Users info on console"),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        UserInfoOnConsole(),))),
            RaisedButton(
                child: Text("Users info on screen"),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        UserInfoOnScreen(),))),
            RaisedButton(
                child: Text("logout"),
                onPressed: () => Logout()),
          ],
        ),
      ),
    );
  }



  Scaffold UnauthenticatedScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column (

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("sign in "),
              onPressed: () => Login()),
            RaisedButton(
                child: Text("logout"),
                onPressed: () => Logout()),

          ],

        ) ,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return isauth ? AuthencatedScreen() : UnauthenticatedScreen();
  }
}

