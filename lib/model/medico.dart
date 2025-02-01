import 'package:cloud_firestore/cloud_firestore.dart';

class Medico {
  int? id;
  String? nome;
  String? especialidade;

  Medico(this.id, this.nome, this.especialidade);

   Map<String, dynamic> toFirebase(){
    return {
      'id': id,
      'nome': nome,
      'especialidade': especialidade

    };

   }

  Medico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    especialidade = json['especialidade'];
  }

  factory Medico.fromFirebase(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return Medico.fromJson(dados);

  }

}