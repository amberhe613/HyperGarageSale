import 'package:flutter/material.dart';
import 'package:winter2019/helper/auth.dart';
import 'package:winter2019/screens/login_page.dart';

void main() {
  runApp(MaterialApp(
    home: new LoginPage(auth: new Auth())
  ));
}