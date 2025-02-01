

  import 'package:agendamento/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDBcontroller {
    final CollectionReference collection =
     FirebaseFirestore.instance.collection("Usuario");

     Future<void> adicionarUsuario(User usuario) {
      return collection.add(usuario.toFirebase());

     }

    Future<void> updateUsuario(User usuario, String doc) {
      return collection.doc(doc).update(usuario.toFirebase());


    }

    Future<User> getUsuario(String doc) async {
      final DocumentSnapshot result = await collection.doc(doc).get();
      return User.fromFirebase(result);

    }



  }