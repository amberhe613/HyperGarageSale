library lib;

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'package:winter2019/src/util/authentication.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        home: new Scaffold(
          appBar: new AppBar(
            title: const Text('HyperGarageSale'),
          ),
          body: new Container(
            padding: new EdgeInsets.only(left: 10.0, right: 10.0),
            child: new MyCustomForm(),
          ),
        )
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter title of the item'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          new TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter price'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          new TextFormField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'Enter description of the item',
              contentPadding: const EdgeInsets.only(top:10.0, bottom: 60.0),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('New post is adding!')));
                  }
                },
                child: Text('Submit')
            ),
          ),
        ],
      ),
    );
  }
}