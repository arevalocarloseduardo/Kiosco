import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/Models/Productos.dart';

class DB{
  final db = Firestore.instance;

  Future<Productos> getProductos(String id)async{
    var snap= await db.collection('Productos').document(id).get();
    return Productos.fromMap(snap.data);
  }
  Stream<Productos>streamProductos(String id){
    return db.collection("Productos").document(id).snapshots().map((snap)=>Productos.fromMap(snap.data));
  }

  //Stream<List<>>
  Stream<QuerySnapshot>initStream(){
    return db.collection('Productos').snapshots();
  }

  Future<String>crearDatos(String name)async{
    DocumentReference ref= await db.collection("Productos").add({'name':'nombre'});
    return ref.documentID;
  }
  
  Future<void>leerDatos(String id)async{
    DocumentSnapshot snapshot= await db.collection("Productos").document(id).get();
    print(snapshot.data['name']);
  }
  
  Future<void>actualizarDatos(DocumentSnapshot doc)async{
    await db.collection("Productos").document(doc.documentID).updateData({'todo':'nuevo dato'});
  }
  Future<void>eliminarDatos(DocumentSnapshot doc)async{
    await db.collection("Productos").document(doc.documentID).delete();
  }

}
DB db = DB();