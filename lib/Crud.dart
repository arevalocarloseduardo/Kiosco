import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Crud {
  String miId;

  void crearDatos(nombre) async {
  await  Firestore.instance
        .collection('CRUD')
        .add({'nombre': '$nombre', 'funcion': randomTodo()});
  }
  void crearProducto(producto) async {
  await  Firestore.instance
        .collection('Productos')
        .add(producto);
  }
  void leerDato(id) async {
        DocumentSnapshot snapshot=await Firestore.instance.collection('CRUD')
        .document(id)
        .get();
    print(snapshot.data['nombre']);
  }
    void actualizarDato(DocumentSnapshot doc) async {
    await Firestore.instance
        .collection('CRUD')
        .document(doc.documentID)
        .updateData({'funcion': 'porfavor'});
  }
    void eliminarDato(DocumentSnapshot doc) async {
    await Firestore.instance
        .collection('CRUD')
        .document(doc.documentID)
        .delete();
   
  }

/*
  Future<void> addData(id, cardData) async {
    Firestore.instance
        .collection('remiseros')
        .document(id)
        .collection('viajesConfirmar')
        .document(miId)
        .setData(cardData);
  }

  Future<void> agregarViaje(cardData) async {
    Firestore.instance
        .collection('viajes')
        .document()
        .setData(cardData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> agregarRemis(id, cardData) async {
    Firestore.instance
        .collection('remiseros')
        .document(id)
        .setData(cardData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> agregarCliente(id, cardData) async {
    Firestore.instance.collection('cliente').document(id).setData(cardData);
  }

  verValor(id) async {
    return await Firestore.instance
        .collection('remiseros')
        .document(id)
        .collection('viajesConfirmar')
        .document("s")
        .collection('carname')
        .snapshots();
  }

  getData() async {
    return await Firestore.instance.collection('viajes').snapshots();
  }
*/
 String randomTodo() {

    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'caso 1';
        break;
      case 2:
        todo = 'caso 2';
        break;
      case 3:
        todo = 'caso 4';
        break;
      default:
        todo = 'caso 5';
        break;
    }
    return todo;

  }
}
