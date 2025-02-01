import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamento {
  int? id;
  String? nome;
  String? telefone;
  String? data;
  String? hora;
  String? tipo;

  // Construtor
  Agendamento({
    this.id,
    this.nome,
    this.telefone,
    this.data,
    this.hora,
    this.tipo,
  });

  // Método para enviar dados para o Firebase
  Map<String, dynamic> toFirebase() {
    return {
      'id': id, // O ID pode ser gerado pelo Firestore ou você pode atribuir manualmente se necessário
      'nome': nome,
      'telefone': telefone,
      'data': data,
      'hora': hora,
      'tipo': tipo,
    };
  }

  // Construtor para criar um Agendamento a partir de dados do Firebase
  Agendamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    data = json['data'];
    hora = json['hora'];
    tipo = json['tipo'];
  }

  // Factory para criar um Agendamento a partir de um DocumentSnapshot do Firebase
  factory Agendamento.fromFirebase(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return Agendamento.fromJson(dados);
  }
}
