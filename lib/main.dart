import 'package:flutter/material.dart';
import 'package:mobile_tp/screens/MysteryNumberApp.dart';
import 'package:mobile_tp/screens/ProgressionPage.dart';

void main() {
  runApp(MaterialApp(home: ProgressionPage(totalNiveaux: 10, niveauxCompletes: 0),));
}