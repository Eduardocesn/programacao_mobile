import 'package:flutter/material.dart';

Widget bottomBar(){
  return BottomAppBar(
    color: Color.fromRGBO(226, 81, 81, 1),
    child: Center(
      child: Text(
        "Diário Oficial de Recife",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}