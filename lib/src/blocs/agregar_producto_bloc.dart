
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
 await Firestore.instance
        .collection('Productos')
        .add(p.toJson());
   
  }
  void actualizaP(Productos p)async {   
    //falta poner por si recive un null
   agregarProducto.sink.add(p);
 await Firestore.instance
        .collection('Productos').document("${p.keyProducto}")
        .updateData(p.toJson());
   
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