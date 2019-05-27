import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/proveedor_bloc.dart';
import 'package:contabilidad/old/repositorio/base_de_datos.dart';

class EjemploBloc implements BlocBase{
  EjemploBloc(){
    db.initStream().listen((data)=>_entraFirestore.add(data));  
  }
  String id;
  final _idController= StreamController<String>();
  Stream<String> get saleId => _idController.stream;
  Sink<String> get _entraId => _idController.sink;
  final _firestoreController = StreamController<QuerySnapshot>();
  Stream<QuerySnapshot>get saleFirestore => _firestoreController.stream;  
  Sink<QuerySnapshot> get _entraFirestore => _firestoreController.sink;

  void leerDatos()async{
    await db.leerDatos(id);
  }
  void actualizarDatos(DocumentSnapshot doc)async{
    await db.actualizarDatos(doc);
  }
  void eliminarDatos(DocumentSnapshot doc)async{
    await db.eliminarDatos(doc);
    id=null;
    _entraId.add(id);
  }
  void crearDatos(String name)async{
    String id = await db.crearDatos(name);
    this.id=id;
    _entraId.add(id);
  }

  @override
  void dispose() {
    _idController.close();
    _firestoreController.close();
  }
   
}