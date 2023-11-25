
// ignore_for_file: prefer_const_constructors

//logout fn
import 'package:flutter/material.dart';
import 'package:medilink/guest/pages/login.dart';

logOut(BuildContext context){
      showDialog(context: context, 
      builder: (BuildContext context){
          return AlertDialog(
            title: Text("Log Out"),
            content: Text("Are you sure ?"),
            actions: [
              TextButton(onPressed: (){
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
              }, child: Text("Confirm")),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Close"))
            ],
          );
      });
    }