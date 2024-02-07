import 'package:flutter/material.dart';
import '/components/bottom_bar.dart';
import '/screens/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Consulta'),
        ),
        body: SearchScreen(),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}