import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:fanpage2/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String post;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    checkType();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
        home: Scaffold(
          appBar: AppBar(
              title: Text('Welcome to My Lonely Fans hehe'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.logout,color: Colors.white),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            content: Text('Are you sure you want to log out?'),
                            actions: <Widget>[

                              TextButton(
                                child: Text('Close'),
                                onPressed: () => Navigator.pop(context, 'Close'),
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  auth.signOut();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
                                },
                              ),
                            ]
                        )
                    )
                )
              ]
          ),

          body: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      child: ListTile(
                        title: Text(doc['content']),
                      ),
                    );
                  }).toList(),
                );
            },
          ),

      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
        onPressed: ()=> showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: Text('Enter a message:'),
                content: TextField(
                    onChanged: (value){
                      setState((){
                        post = value.trim();
                      });
                    }
                ),
                actions: <Widget>[
                  TextButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.pop(context, 'Close')
                  ),
                  TextButton(
                    child: Text('POST MESSAGE'),
                    onPressed: () {
                      CollectionReference user = firestore.collection('posts');
                      user.add({
                        'date_time': DateTime.now(),
                        'content': post
                      }).then((value)=>print("Message posted")).catchError((error)=>print("Failed to post message:$error"));
                      Navigator.pop(context); //navigate back to homepage
                    },
                  ),
                ]
            )
        ),
        child: Icon(Icons.add),
      ),
    ),
  ),
    );
}

  Future <bool?> checkType() async  {
    try{
      await firestore.collection('user').where('uid', isEqualTo: auth.currentUser!.uid).get().then((QuerySnapshot snapshot){
        snapshot.docs.forEach((doc){
          if(doc['type'] == 'Admin'){
            setState((){
              isVisible=true;
            });
          }
        });
        return isVisible;
      });
    } on FirebaseAuthException catch(e){
      return false;
    }
  }
}