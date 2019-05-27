import 'package:contabilidad/src/blocs/list_productos_bloc.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/screens/productos/card_producto.dart';
import 'package:flutter/material.dart';
class ListaVentas extends StatefulWidget {
  @override
  _ListaVentasState createState() => _ListaVentasState();
}

class _ListaVentasState extends State<ListaVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
         
          title: Text("Productos Vendidos"),
          centerTitle: true,
          
        ),
        body: listaVentas());
  }

  Widget listaVentas() {
    return Container(     
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
    );
  }
}
