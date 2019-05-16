import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/CarritoPage.dart';
import 'package:contabilidad/SistemaCrud.dart';
import 'package:contabilidad/SistemaKiosco.dart';
import 'package:contabilidad/VerProductos.dart';
import 'package:flutter/material.dart';

class Kiosco extends StatefulWidget {
  Kiosco(Carrito carrito, int tabIndex);
  Carrito carrito;
  int tabIndex;

  @override
  _KioscoState createState() => _KioscoState();
}

class _KioscoState extends State<Kiosco> {
  //declaro que inicie en el tab 0
  int paginaInicial = 0;
  //declaro los page
  SistemaCrud sistemaCrud;
  
  VerProducto verProducto;
  CarritoPage carritoPage;
  List<Widget> paginas;
  Carrito carrito;
  Widget verPagina;

  //hasta aca es para hacer los tabs
  @override
  void initState() {
    sistemaCrud = SistemaCrud();
    verProducto = VerProducto(carrito);
    carritoPage = CarritoPage(carrito);
    //almaceno las paginas
    paginas = [sistemaCrud, verProducto, carritoPage];
    //recibo el indice y lo guardo
    paginaInicial = widget.tabIndex;
    //muestro el indice guardado
    verPagina = paginas[widget.tabIndex];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: verPagina,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: paginaInicial,
        onTap: (int index) {
          setState(() {
            paginaInicial = index;
            verPagina = paginas[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("Ver Productos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Carrito")),
        ],
      ),
    );
  }

  Carrito obtenerCarrito() {
    return carrito;
  }
}
