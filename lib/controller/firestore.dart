import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';



class FirestoreService {
  //pega coleção
final CollectionReference medicos = 
FirebaseFirestore.instance.collection('medicos');

// Adiciona um novo médico ao banco de dados
Future<void> addMedico(String medico) {

  return medicos.add({
    'Nome': medico,
    'timestamp': Timestamp.now(),

  });

}

//Pega as informações do banco 
Stream<QuerySnapshot> getMedicoStream() {
  final medicoStream =
  medicos.orderBy('timestamp', descending: true).snapshots();

  return medicoStream;

}

// Atualiza informação
Future<void> updateMedico(String docID, String novoMedico){
  return medicos.doc(docID).update({
  'Nome': novoMedico,
  'timestamp': Timestamp.now(),
  });

}

// Deleta Informação
Future<void> deleteMedico(String docID) {
  return medicos.doc(docID).delete();

}


}