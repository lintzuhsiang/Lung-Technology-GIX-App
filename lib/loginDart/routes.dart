import 'package:flutter/material.dart';
import './patient.dart';
import './main.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context)  => new HomeScreen(),
  '/': (BuildContext context) => new LoginScreen(),
}
