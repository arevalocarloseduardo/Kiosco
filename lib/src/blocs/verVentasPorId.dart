import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:rxdart/rxdart.dart';

class VerVentasPorId {
  BehaviorSubject<List<CarritoModelo>> _productosCollection = BehaviorSubject<List<CarritoModelo>>();
  
  BehaviorSubject<List<Productos>> _productosCollection2 = BehaviorSubject<List<Productos>>();

  BehaviorSubject<String> idVenta = BehaviorSubject<String>();
  Function(String) get cambiarId => idVenta.sink.add;
  //recuperar datos

  Stream<String> get id => idVenta.stream;
  BehaviorSubject<List<CarritoModelo>> get productosList =>   _productosCollection;
  
  BehaviorSubject<List<Productos>> get productosList2 =>   _productosCollection2;


  void dispose() {
    _productosCollection.close();
    idVenta.close();
  }
  void crearLista(String idV)async{    
      productosList.sink.add(new List());
    var q = await Firestore.instance
        .collection('productosVendidos');
    q.snapshots().listen((query) {
      if (query.documentChanges.length == 0) {
        productosList.sink.add(new List());
      }
      query.documentChanges.forEach((val) {
        CarritoModelo _carrito = new CarritoModelo.fromSnapshot(val.document);
        if (val.type == DocumentChangeType.added) {
          _anadir(_carrito,idV);
        }
      });
    });    
  }

  void crearListaPro(String idV)async{    
      productosList2.sink.add(new List());
    var q = await Firestore.instance
        .collection('Productos');
    q.snapshots().listen((query) {
      if (query.documentChanges.length == 0) {
        productosList2.sink.add(new List());
      }
      query.documentChanges.forEach((val) {
        Productos _carrito2 = new Productos.fromSnapshot(val.document);
        if (val.type == DocumentChangeType.added) {
          _anadir2(_carrito2,idV);
        }
      });
    });    
  }
  void _anadir(CarritoModelo carrito, String idV) {
    
    if (productosList.value == null) {
      if (productosList.isClosed) return;
      productosList.sink.add(new List());
    }
    if(carrito.idCarrito==idV){  
      List<CarritoModelo> car = productosList.value;
      car.add(carrito);      
    productosList.sink.add(car);
    }   
  }
  
  void _anadir2(Productos carrito, String idV) {
    
    if (productosList.value == null) {
      if (productosList.isClosed) return;
      productosList.sink.add(new List());
    }
    if(carrito.keyProducto==idV){  
      List<Productos> car = productosList2.value;
      car.add(carrito);      
    productosList2.sink.add(car);
    }   
  }
}

//instancia global
final verVentasPorId = VerVentasPorId();
