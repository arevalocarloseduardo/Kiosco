import 'package:contabilidad/src/blocs/ventas_bloc.dart';
import 'package:contabilidad/src/modelos/ventas_modelo.dart';
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(Icons.add, size: 30),
                onTap: () {
                  irAgregarVentas(context);
                },
              ),
            )
          ],
        ),
        body: listaVentas());
  }

  irAgregarVentas(context) {
    var uid=DateTime.now().toString();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgregarVenta(uid:uid)),
    );
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
