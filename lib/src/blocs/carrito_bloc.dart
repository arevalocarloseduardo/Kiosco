
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:rxdart/rxdart.dart';

class CarritoBloc{
  BehaviorSubject<List<Productos>> _cardsCollection =
      BehaviorSubject<List<Productos>>();

  //Retrieve data from Stream
  BehaviorSubject<List<Productos>> get carritoList => _cardsCollection;

  void initialData() async {
    carritoList.sink.add(new List());
  }

  CarritoBloc() {
    initialData();
  }

  void addCardToList(Productos newCard) {
    
  List<Productos> _carrito=carritoList.value;
  _carrito.add(newCard);
    _cardsCollection.sink.add(_carrito);
    }

  void dispose() {
    _cardsCollection.close();
  }
}

final carritoBloc = CarritoBloc();
