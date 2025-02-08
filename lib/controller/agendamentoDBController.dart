import 'package:agendamento/model/agendamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoDBController {
  final CollectionReference collection = FirebaseFirestore.instance.collection("Agendamento");
  final CollectionReference notificacoesCollection = FirebaseFirestore.instance.collection("Notificacoes");

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

  // Cancelar Agendamento e salvar notificação
  Future<void> cancelarAgendamento(String docId, String nome) async {
    // Obtém a hora exata do cancelamento no formato HH:mm
    Timestamp agora = Timestamp.now();
    DateTime dataHora = agora.toDate();
    String horaCancelamento = "${dataHora.hour}:${dataHora.minute.toString().padLeft(2, '0')}";

    // Remove a consulta do banco de dados
    await collection.doc(docId).delete();

    // Salva a notificação do cancelamento
    await notificacoesCollection.add({
      'Nome': nome,
      'mensagem': "Consulta no nome de $nome, cancelada às $horaCancelamento.",
      'timestamp': agora,
    });
  }
}
