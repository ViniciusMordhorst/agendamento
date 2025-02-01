import 'package:agendamento/model/agendamento.dart';
import 'package:agendamento/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamentodbcontroller {
    final CollectionReference collection =
     FirebaseFirestore.instance.collection("Agendamento");

     Future<void> adicionarAgendamento(Agendamento agendamento) {
      return collection.add(agendamento.toFirebase());

     }

    Future<void> updateAgendamento(User usuario, String doc) {
      return collection.doc(doc).update(usuario.toFirebase());


    }

    Future<User> getAgendamento(String doc) async {
      final DocumentSnapshot result = await collection.doc(doc).get();
      return User.fromFirebase(result);

    }



  }