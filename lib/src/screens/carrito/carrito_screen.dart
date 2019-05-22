//Se mostrara una listas de ventas
//tendrá tabs para ver ventas del dia
import 'package:contabilidad/modelos/productos_modelo.dart';
import 'package:contabilidad/src/blocs/list_productos_bloc.dart';
import 'package:contabilidad/src/screens/carrito/card_producto.dart';
import 'package:contabilidad/src/screens/carrito/horizontal_list.dart';
import 'package:flutter/material.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text("Mis Productos"),
          centerTitle: true,
          actions: <Widget>[Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(onTap: (){},child: Icon(Icons.search)),
          )],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.blueAccent,
          ),
          onPressed: () {},
        ),
        body: listaVentas());
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
          padding: EdgeInsets.only(top: 130,bottom: 15),
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
