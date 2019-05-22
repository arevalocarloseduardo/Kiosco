import 'package:contabilidad/src/screens/carrito/carrito_screen.dart';
import 'package:contabilidad/src/screens/configuracion/configuracion_screen.dart';
import 'package:contabilidad/src/screens/ventas/ventas_kiosco_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class KioscoScreen extends StatefulWidget {
  @override
  _KioscoScreenState createState() => _KioscoScreenState();
}

class _KioscoScreenState extends State<KioscoScreen> {
  int _screenIndice = 0;
  //Crear Screens
  final VentasScreen _ventasScreen = VentasScreen();
  final CarritoScreen _carritoScreen = CarritoScreen();
  final ConfinguracionScreen _configuracionScreen = ConfinguracionScreen();
  Widget _mostrarScreen = VentasScreen();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: barraNavegacion(),
      body: Container(
        color: Colors.blueAccent,
        child: _mostrarScreen
      ),
    );
  }

Widget _seleccionarScreen(int screen) {
    switch (screen) {
      case 0:
        return _ventasScreen;
      case 1:
        return _carritoScreen;
      case 2:
        return _configuracionScreen;
        break;
      default:
        return Container(
          child: Text("hola"),
        );
    }
  }

Widget barraNavegacion() {
    return CurvedNavigationBar(
      index: _screenIndice,
      height: 55.0,
      items: <Widget>[
        Icon(Icons.timeline, color: Colors.blue, size: 30),
        Icon(Icons.local_grocery_store, color: Colors.blue, size: 30),
        Icon(Icons.settings, color: Colors.blue, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      onTap: (int indice) {
        setState(() {
          _mostrarScreen = _seleccionarScreen(indice);
        });
      },
    );
  }
}
