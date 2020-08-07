import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  String username;
  final _formkey  = GlobalKey<FormState> ();
  submit(){
    _formkey.currentState.save();
    Navigator.pop(context,username);
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
            children: [
              Container(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Username', style: TextStyle(
                        fontSize: 25
                      ),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Form(
                        key: _formkey,
                          child: TextFormField(
                            onSaved: (val) => username = val,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                              hintText: "Atleast 3 Character required",

                            ),
                          )),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () =>  submit(),
                  )
                ],),
              )
            ],
      ),
    );
  }
}
