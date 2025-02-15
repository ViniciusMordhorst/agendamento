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
    try {
      // Obtém a hora exata do cancelamento no formato HH:mm
      Timestamp agora = Timestamp.now();
      DateTime dataHora = agora.toDate();
      Timestamp horaCancelamento = Timestamp.now();

      // Remove o agendamento do banco de dados
      await collection.doc(docId).delete();

      // Salva a notificação de cancelamento
      await notificacoesCollection.add({
        'Nome': nome,
        'mensagem': "Consulta no nome de $nome, cancelada às $horaCancelamento.",
        'timestamp': agora,
      });

      // Se necessário, você pode até retornar um valor ou lançar uma exceção, dependendo da lógica de negócios.
    } catch (e) {
      // Tratar qualquer erro
      print("Erro ao cancelar agendamento: $e");
      // Aqui você pode lançar uma exceção ou lidar de forma adequada com o erro
    }
  }
}
