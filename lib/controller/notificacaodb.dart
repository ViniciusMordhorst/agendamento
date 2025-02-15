import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacaoDB {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> salvarNotificacao(String nome, String hora, String data) async {
    await _db.collection('Notificacoes').add({
      'Nome': nome,
      'data': data,
      'hora': hora,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
