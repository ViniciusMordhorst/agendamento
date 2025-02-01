import 'package:agendamento/model/agendamento.dart';
import 'package:agendamento/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoDBController {
  final CollectionReference collection = FirebaseFirestore.instance.collection("Agendamento");

  // Adicionar Agendamento
  Future<void> adicionarAgendamento(Agendamento agendamento) {
    return collection.add(agendamento.toFirebase());
  }

  // Atualizar Agendamento
  Future<void> updateAgendamento(Agendamento agendamento, String docId) {
    return collection.doc(docId).update(agendamento.toFirebase());
  }

  // Obter Agendamento
  Future<Agendamento> getAgendamento(String docId) async {
    final DocumentSnapshot result = await collection.doc(docId).get();
    return Agendamento.fromFirebase(result);
  }
}



  