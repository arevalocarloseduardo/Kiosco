import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/Productos.dart';

class Carrito {
  List<Productos> _listaProductos = new List<Productos>();

  void agregarProducto(Productos producto) async {
    await _listaProductos.add(producto);
  }

  void eliminarProducto(Productos producto) {
    _listaProductos.remove(producto);
  }

  List<Productos> getListaProducto() {
    return _listaProductos;
  }

}
