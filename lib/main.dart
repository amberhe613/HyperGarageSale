import 'package:flutter/material.dart';
import 'auth.dart';
import 'login_page.dart';

void main() {
  runApp(MaterialApp(
    home: new LoginPage(auth: new Auth())
  ));
}