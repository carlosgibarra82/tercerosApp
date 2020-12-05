import 'package:flutter/material.dart';
import 'package:tercerosApp/ui/DetailView.dart';
import 'package:tercerosApp/ui/MainView.dart';
import 'package:provider/provider.dart';

import 'core/services/app_state.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AppState(context),
        child: MaterialApp(
          title: 'Terceros Demo',
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => MainView(
                  title: 'Terceros',
                ),
            'detail': (BuildContext context) => DetailView(),
          },
        ));
  }
}
