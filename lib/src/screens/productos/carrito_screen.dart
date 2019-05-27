import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/blocs/list_productos_bloc.dart';
import 'package:contabilidad/src/screens/productos/agregar_producto.dart';
import 'package:flutter/material.dart';

import 'card_producto.dart';
import 'horizontal_list.dart';

class ProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(onTap: () {}, child: Icon(Icons.search)),
          ),
          title: Text("Mis Productos"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(Icons.add, size: 30),
                onTap: () {
                  irAgregarProducto(context);
                },
              ),
            )
          ],
        ),
        body: listaVentas());
  }

  irAgregarProducto(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgregarProducto()),
    );
  }

  Widget listaVentas() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Categoria",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: HorizontalList(),
        ),
        Container(
          padding: EdgeInsets.only(top: 130, bottom: 15),
          child: StreamBuilder<List<Productos>>(
            stream: productosBloc.productosList,
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      itemCount: (snapshot.data.length),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return CardProducto(modeloP: snapshot.data[index]);
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
