import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppState with ChangeNotifier {
  AppState(BuildContext context);
  String id;
  String get getId => id;
  setId(String id) => this.id = id;
}
