import 'dart:io';
import 'package:contabilidad/src/blocs/agregar_producto_bloc.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/screens/productos/agregar_codBarra.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AgregarProducto extends StatefulWidget {
  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {
  final formKey = GlobalKey<FormState>();
  final textCodBarraControl = TextEditingController();
  int _codBarra;
  String _nombre;
  String _imgUrl;
  double _precioVenta;
  File _image;
  String filename;
  bool datos = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Agregar Productos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: datos == false ? formularioAgregar(context) : carga(),
    );
  }

  Widget formularioAgregar(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                  ),
                  TextFormField(
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Precio",
                        prefixIcon: Icon(Icons.monetization_on)),
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
          ),
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

  Widget carga() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Agregando Producto a la base de Datos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ));
  }
}
