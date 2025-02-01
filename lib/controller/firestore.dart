import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';



class FirestoreService {
  //pega coleção
final CollectionReference medicos = 
FirebaseFirestore.instance.collection('Medicos');

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

////////////////////////////////////////////////////////////////////////

final CollectionReference hospitais = 
FirebaseFirestore.instance.collection('Hospitais');

// Adiciona um novo médico ao banco de dados
Future<void> addHospital(String hospital) {

  return hospitais.add({
    'Nome': hospital,
    'timestamp': Timestamp.now(),

  });

}

//Pega as informações do banco 
Stream<QuerySnapshot> getHospitalStream() {
  final hospitalStream =
  hospitais.orderBy('timestamp', descending: true).snapshots();

  return hospitalStream;

}

// Atualiza informação
Future<void> updateHospital(String docID, String novoHospital){
  return hospitais.doc(docID).update({
  'Nome': novoHospital,
  'timestamp': Timestamp.now(),
  });

}

// Deleta Informação
Future<void> deleteHospital(String docID) {
  return hospitais.doc(docID).delete();

}


}