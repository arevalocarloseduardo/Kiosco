
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:rxdart/rxdart.dart';

class CarritoBloc{
  BehaviorSubject<List<CarritoModelo>> _cardsCollection =
      BehaviorSubject<List<CarritoModelo>>();

  //Retrieve data from Stream
  BehaviorSubject<List<CarritoModelo>> get carritoList => _cardsCollection;

  void initialData() async {
    carritoList.sink.add(new List());
  }

  CarritoBloc() {
    initialData();
  }

  void addCardToList(CarritoModelo newCard,String uid) async{
    
  List<CarritoModelo> _carrito=carritoList.value;
  _carrito.add(newCard);
    _cardsCollection.sink.add(_carrito);
    
   var s= Firestore.instance.collection('productosVendidos').document();
        newCard.idCarrito=uid;
      await s.setData(newCard.toJson());
    }
    cerrarlista(){
      _cardsCollection.sink.add(List());
    }

  void dispose() {
    _cardsCollection.close();
  }
}

final carritoBloc = CarritoBloc();
