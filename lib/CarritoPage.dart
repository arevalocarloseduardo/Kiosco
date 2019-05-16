import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/Productos.dart';
import 'package:contabilidad/SistemaKiosco.dart';
import 'package:flutter/material.dart';

class CarritoPage extends StatefulWidget {

 CarritoPage(Carrito carrito);

  Carrito carrito;
  


  @override
  _CarritoPageState createState() => _CarritoPageState();
}


class _CarritoPageState extends State<CarritoPage> {
  
  SistemaKiosco sistemaKiosco=new SistemaKiosco();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: 
         widget.carrito.getListaProducto().map(_construirTarjetas).toList(),          
        ),
      ),
    );
  }

  Widget _construirTarjetas(Productos producto) {
    return new ListTile(
      title: new Text(producto.nombre),
      subtitle: new Text(producto.imgUrl),
      leading: new Icon(Icons.map),
      onTap: () {},
    );
  }
}
