import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/control.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes:{
  '/':(context) => Home(),
  '/home': (context) => Home(),
  '/control': (context) => Control()}
  ,

));

