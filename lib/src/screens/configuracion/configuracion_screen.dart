import 'package:flutter/material.dart';
class ConfinguracionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Mis Estadisticas"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.library_add,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      ),
      body: Container(
          color: Colors.blueAccent, child: Center(child: Text("Proximamente"))),
    );
  }
}