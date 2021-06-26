import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fanpage2/post.dart';
import 'package:fanpage2/login.dart';

class signUp extends StatefulWidget{
  @override
  _signUpState createState() => new _signUpState();
}

class _signUpState extends State<signUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String first, last, email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late User? user = auth.currentUser;
  late String id = user!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign Up'), centerTitle: true),
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      validator: (String? input){
                        //if nothing is input into field, return error
                        if(input == null || input.isEmpty){
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){
                          first = value.trim();
                          first = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name'
                      ),
                    ),
                  ),
                  //start of last name text box field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                        validator: (String? input){
                          //if nothing is input into field, return error
                          if(input == null || input.isEmpty){
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            last = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name'
                        )
                    ),
                  ),
                  //start of email text box field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                        validator: (String? input){
                          //if nothing is input into field, return error
                          if(input == null || input.isEmpty){
                            return 'Enter your Email';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState((){
                            email = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email'
                        )
                    ),
                  ),
                  //start of password text box field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      validator: (String? input){
                        //if nothing is input into field, return error
                        if(input == null || input.isEmpty){
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){
                          password = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password: 6 or more characters'
                      ),
                      //hides characters when typing
                      obscureText: true,
                    ),
                  ),
                  //start of Register button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          signUp(first, last, email, password);
                          signUp(first, last, email, password);
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(primary: Colors.pink[600]
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Center(
  //       child: OutlinedButton(onPressed: () {
  //         //Navigator.push(context, Home());
  //
  //       }, child: Text("Go To Homepage")),
  //     ),
  //   );
  // }
  Future<String?> signUp(String first, String last, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      CollectionReference user = firestore.collection('user'); //to add user info
      user.add({
        'uid': id,
        'first': first,
        'last': last,
        'dateTime': DateTime.now(),
        'type': 'customer'
      }).then((value) => print("User Successfully Added")).catchError((error) =>
          print("Unable to Add User:$error"));

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage())); //goes back to homepage

      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}