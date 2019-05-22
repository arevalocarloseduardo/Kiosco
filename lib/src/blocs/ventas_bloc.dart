import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/modelos/ventas_modelo.dart';
import 'package:rxdart/rxdart.dart';

class VentasBloc{
  BehaviorSubject<List<Venta>>_ventasCollection=BehaviorSubject<List<Venta>>();
  //recuperar datos
  
  BehaviorSubject <List<Venta>> get ventasCollection=>_ventasCollection;

   void iniciarDatos()async{
     var q = await Firestore.instance.collection('ventas');

    q.snapshots().listen((querySnapshot) {
      if (querySnapshot.documentChanges.length == 0) {
        ventasCollection.sink.add(new List());
      }

      querySnapshot.documentChanges.forEach((val) {
        Venta _place =
            new Venta.fromSnapshot(val.document);
        if (val.type == DocumentChangeType.added) {
          _doAddNew(_place);
        } else if (val.type == DocumentChangeType.modified) {
          _doUpdate(_place);
        } else if (val.type == DocumentChangeType.removed) {
          _doRemove(_place);
        }
      });
    });
  }
  void _doAddNew(Venta p) {
    if (ventasCollection.value == null) {
      if (ventasCollection.isClosed) return;
      ventasCollection.sink.add(new List());
    }

    List<Venta> pls = ventasCollection.value;
    pls.add(p);

    if (ventasCollection.isClosed) return;
    return _sort(pls);
  }

  void _doUpdate(Venta p) {
    if (ventasCollection.value == null) {
      if (ventasCollection.isClosed) return;
      ventasCollection.sink.add(new List());
    }

    List<Venta> pls = ventasCollection.value;
    int idx = pls.indexWhere((cResult) => cResult == p);
    pls[idx] = p;

    if (ventasCollection.isClosed) return;
    return _sort(pls);
  }

  void _doRemove(Venta p) {
    if (ventasCollection.value == null) {
      if (ventasCollection.isClosed) return;
      ventasCollection.sink.add(new List());
    }

    List<Venta> pls = ventasCollection.value;
    int idx = pls.indexWhere((cResult) => cResult.idVenta == p.idVenta);
    pls.removeAt(idx);
    if (ventasCollection.isClosed) return;
    return _sort(pls);
  }

  void _sort(List<Venta> pls) {
    pls.sort((Venta a, Venta b) {
      return a.idCarrito.compareTo((b.idCarrito));
    });

    ventasCollection.sink.add(pls);
  }

  VentasBloc(){
      iniciarDatos();
  }
  void dispose(){
    _ventasCollection.close();
  }
}
//instancia global
final ventasBloc=VentasBloc();