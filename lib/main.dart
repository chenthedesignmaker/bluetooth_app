import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/control.dart';
import 'pages/connecting.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes:{
  '/':(context) => Home(),
  '/home': (context) => Home(),
  '/control': (context) => Control(),
  '/connecting':(context)=> Connecting()}
  ,

));

