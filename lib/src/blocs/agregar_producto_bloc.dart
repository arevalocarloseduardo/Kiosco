
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:rxdart/rxdart.dart';

class AgregarProductosBloc{
  BehaviorSubject<Productos>_agregarProductosCollection=BehaviorSubject<Productos>();
  //recuperar datos
  
  BehaviorSubject <Productos> get agregarProducto=>_agregarProductosCollection;

   void iniciarDatos()async{
  }
  void agregraP(Productos p)async {   
   agregarProducto.sink.add(p);

   var s= Firestore.instance.collection('Productos').document();
        p.keyProducto=s.documentID;
      await s.setData(p.toJson());
        
  }
  void actualizaP(Productos p)async {   
    //falta poner por si recive un null
   agregarProducto.sink.add(p);
 await Firestore.instance
        .collection('Productos').document(p.keyProducto).setData(p.toJson());
   
  }
  
  void borrarP(Productos p)async {   
   agregarProducto.sink.add(p);
 await Firestore.instance
        .collection('Productos').document(p.keyProducto).delete();
   
  }
  AgregarProductosBloc(){
      iniciarDatos();
  }
  void dispose(){
    _agregarProductosCollection.close();
  }
}
//instancia global
final agregarProductosBloc=AgregarProductosBloc();