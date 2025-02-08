import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notificacaotela extends StatefulWidget {
  @override
  _NotificacaotelaState createState() => _NotificacaotelaState();
}

class _NotificacaotelaState extends State<Notificacaotela> {
  final CollectionReference notificacoesCollection =
      FirebaseFirestore.instance.collection("Notificacoes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: const Text("Notificações"),
        backgroundColor: Colors.blue[400],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: notificacoesCollection
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text("Nenhuma notificação disponível."));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: snapshot.data!.docs.map((doc) {
                Map<String, dynamic> notificacao =
                    doc.data() as Map<String, dynamic>;

                String nome = notificacao['Nome'] ?? "Paciente desconhecido";
                String mensagemOriginal = notificacao['mensagem'] ?? "Mensagem não encontrada";
                Timestamp? timestamp = notificacao['timestamp'] as Timestamp?;

                // Convertendo timestamp para uma data legível
                String dataHora = timestamp != null
                    ? "${timestamp.toDate().hour}:${timestamp.toDate().minute.toString().padLeft(2, '0')} - ${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}"
                    : "Data não disponível";

                // Variáveis para a mensagem, ícone e cor
                String mensagem;
                IconData icone;
                Color iconeCor;

                if (mensagemOriginal.contains("cancelada")) {
                  mensagem = "$nome sua consulta foi CANCELADA às $dataHora com sucesso.";
                  icone = Icons.cancel;
                  iconeCor = Colors.red;
                } else {
                  mensagem = "$nome, sua consulta foi agendada para $dataHora.";
                  icone = Icons.check_circle;
                  iconeCor = Colors.green;
                }

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      mensagem,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(icone, color: iconeCor),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
