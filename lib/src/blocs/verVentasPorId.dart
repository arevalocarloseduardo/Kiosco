import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/modelos/ventas_modelo.dart';
import 'package:rxdart/rxdart.dart';

class VerVentasPorId{
  BehaviorSubject<List<Productos>>_productosCollection=BehaviorSubject<List<Productos>>();

  String idCarrito;
  //recuperar datos
  
  BehaviorSubject <List<Productos>> get productosList=>_productosCollection;

   void iniciarDatos()async{
     var q = await Firestore.instance.collection('ventaProductos').where('idCarrit',isEqualTo: idCarrito);

    q.snapshots().listen((querySnapshot) {
      if (querySnapshot.documentChanges.length == 0) {
        productosList.sink.add(new List());
      }
      querySnapshot.documentChanges.forEach((val) {
        Productos place =
            new Productos.fromSnapshot(val.document);
        if (val.type == DocumentChangeType.added) {
          _doAddNew(place);
        }
      });
    });
  }
  void cargarDatos(Venta v){
    idCarrito=v.idCarrito;
    

  }
  void _doAddNew(Productos p) {
    if (productosList.value == null) {
      if (productosList.isClosed) return;
      productosList.sink.add(new List());
    }

    List<Productos> _pls = productosList.value;
    _pls.add(p);

    if (productosList.isClosed) return;
    return _sort(_pls);
  }

  void _doUpdate(Productos p) {
    if (productosList.value == null) {
      if (productosList.isClosed) return;
      productosList.sink.add(new List());
    }

    List<Productos> _pls = productosList.value;
    int idx = _pls.indexWhere((cResult) => cResult.keyProducto == p.keyProducto);
    _pls[idx] = p;

    if (productosList.isClosed) return;
    return _sort(_pls);
  }

  void _sort(List<Productos> pls) {
    pls.sort((Productos a, Productos b) {
      return a.codBarra.compareTo((b.codBarra));
    });

    productosList.sink.add(pls);
  }

  VerVentasPorId(){
      iniciarDatos();
  }
  void dispose(){
    _productosCollection.close();
  }
}
//instancia global
final verVentasPorId=VerVentasPorId();