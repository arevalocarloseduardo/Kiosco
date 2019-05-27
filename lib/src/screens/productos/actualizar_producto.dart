import 'dart:io';

import 'package:contabilidad/src/blocs/agregar_producto_bloc.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/screens/productos/agregar_producto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'agregar_codBarra.dart';

class ActualizarProductoDialog extends StatefulWidget {
  @override
  _ActualizarProductoDialogState createState() =>
      _ActualizarProductoDialogState();
}

class _ActualizarProductoDialogState extends State<ActualizarProductoDialog> {
  final formKey = GlobalKey<FormState>();
  final textCodBarraControl = TextEditingController();  
  final textNombreControl = TextEditingController();    
  final textPrecio = TextEditingController();
  Productos productoActualizados;  
  File _image;
  String filename;
  bool datos = false;
  String _nombre;
  int _codBarra;
  double _precioVenta;

  var _imgUrl;
  @override
  void initState() {
    super.initState();
    textCodBarraControl.text="js";
    textNombreControl.text="lk";
    textPrecio.text="lkl";
    }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Actualizar Datos",style: TextStyle(color: Colors.blueAccent),),
      content: dialogActualizar(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          textColor: Colors.redAccent,
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(productoActualizados);},
          textColor: Colors.blue,
          child: Text("Agregar"),
        ),
      ],
      
    );
  }

  Widget dialogActualizar(context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0.1,
                    top: 0.1,
                    right: 0.1,
                    bottom: 0.1,
                    child: _image == null
                        ? Text(
                            'No hay imagen',
                            style: TextStyle(color: Colors.white),
                          )
                        : Image.file(
                            _image,
                            filterQuality: FilterQuality.none,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: InkWell(
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: 25,
                        ),
                        onTap: () {
                          getGaleria();
                        }),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: InkWell(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        onTap: () {
                          getImage();
                        }),
                  ),
                ],
              ),
              color: Colors.blueAccent,
              height: 150,
              width: 150,
            ),
            TextFormField(controller: textNombreControl,
              decoration: InputDecoration(
                  labelText: "Nombre Producto",
                  prefixIcon: Icon(Icons.note_add)),
              onSaved: (entrada) => _nombre = entrada,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: textCodBarraControl,
              decoration: InputDecoration(
                labelText: "Codigo de Barra",
                prefixIcon: RotatedBox(
                  child: Icon(Icons.line_weight),
                  quarterTurns: 1,
                ),
                suffix: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    getCodBarra(context);
                  },
                  child: RotatedBox(
                    child: Icon(Icons.playlist_add),
                    quarterTurns: 3,
                  ),
                ),
              ),
              onSaved: (entrada) => _codBarra = int.parse(entrada),
            ),
            TextFormField(controller: textPrecio,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Precio", prefixIcon: Icon(Icons.monetization_on)),
              onSaved: (entrada) => _precioVenta = double.parse(entrada),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  agregarDatos(context);
                },
                child: Text("Agregar"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> agregarDatos(context) async {
    formKey.currentState.save();
    //hace una referencia en la base de datos
    StorageUploadTask ref =
        FirebaseStorage.instance.ref().child(filename).putFile(_image);
    //espera una respuestas del server
    productoActualizados=Productos(imgUrl: "onValue",
          cantidad: 1.0,
          keyProducto: "",
          unidad: "",
          codBarra: _codBarra,
          tipo: "",
          nombre: _nombre,
          peso: 1.0,
          precio: 1.0,
          precioDeVenta: _precioVenta);
    setState(() {
      datos = true;
    });
    (await ref.onComplete).ref.getDownloadURL().then((onValue) {
      agregarProductosBloc.agregraP(Productos(
          imgUrl: onValue,
          cantidad: 1.0,
          keyProducto: "",
          unidad: "",
          codBarra: _codBarra,
          tipo: "",
          nombre: _nombre,
          peso: 1.0,
          precio: 1.0,
          precioDeVenta: _precioVenta));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AgregarProducto()),
      );
    }).catchError((kj) {
      print("error");
    });

    return _imgUrl;
  }

  void getCodBarra(context) async {
    String cod =
        await showDialog(builder: (_) => AgregarCodBarra(), context: context);
    setState(() {
      textCodBarraControl.text = cod;
    });
  }

  Future getImage() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera).then((onValue) {
      setState(() {
        _image = onValue;
        filename = basename(_image.path);
      });
    });
  }

  Future getGaleria() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
