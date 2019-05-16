import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/AgregarCarrito.dart';
import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/CarritoPage.dart';
import 'package:contabilidad/Crud.dart';
import 'package:contabilidad/Productos.dart';
import 'package:contabilidad/SistemaKiosco.dart';
import 'package:flutter/material.dart';

class Tarjetas {
  //utilizo el Crud
  Crud _crudObj = Crud();
  SistemaKiosco sistemaKiosco=SistemaKiosco();
 
  //tarjetas que recibe parametros para construir
  Card construirItem(DocumentSnapshot doc) {
    //tiene que estar tal cual en la base de datos doc.data['nombre']
    var nombre = doc.data['nombre'];
    var casos = doc.data['funcion'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'nombre: $nombre',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'casos: $casos',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => _crudObj.actualizarDato(doc),
                  child: Text('Actualizar caso',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => _crudObj.eliminarDato(doc),
                  child: Text('eliminar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card construirProductos(DocumentSnapshot doc,context) {

    Productos productos = Productos.from(doc);
    
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(onTap: (){
            agregarCarrito(context);
                      },
                        leading: Image.network("${productos.imgUrl}",filterQuality: FilterQuality.none,),
                        title: Text(productos.nombre),
                        subtitle: Text("Precio:${productos.precio}"),
                      )),
                      
                );
              }
            
              
            void agregarCarrito(context) async{
             Productos productoCarrito=await  showDialog(context: context,builder: (_)=>AgregarCarrito());
                  if(productoCarrito!=null){
                await SistemaKiosco().getCarrito().agregarProducto(productoCarrito); 
              }  
            }
}
