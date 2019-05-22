import 'package:contabilidad/modelos/ventas_modelo.dart';
import 'package:contabilidad/src/blocs/ventas_bloc.dart';
import 'package:contabilidad/src/screens/ventas/agregar_venta.dart';
import 'package:contabilidad/src/screens/ventas/card_ventas.dart';
import 'package:flutter/material.dart';

//Se mostrara una listas de ventas
//tendrá tabs para ver ventas del dia
class VentasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text("Mis Ventas"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AgregarVenta()),
            );
          },
        ),
        body: listaVentas());
  }

  Widget listaVentas() {
    return Container(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Venta>>(
          stream: ventasBloc.ventasCollection,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return CardVenta(modelo: snapshot.data[index]);
                    },
                    itemCount: (snapshot.data.length),
                  );
          },
        ),
      ),
    );
  }
}
