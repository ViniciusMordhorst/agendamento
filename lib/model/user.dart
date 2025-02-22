import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid; 
  String? nome;
  String? cpf;
  DateTime? dataNascimento;
  String? email;
  String? endereco;
  String? senha;
  String? foto;

  User(this.nome, this.cpf, this.email, this.senha,this.dataNascimento, this.endereco, {this.uid});

  Map<String, dynamic> toFirebase() {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'senha': senha,
      'dataNascimento': dataNascimento,
      'endereco': endereco,
      'foto': foto,
    };
  }

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid']; // Ajuste para buscar o uid
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    senha = json['senha'];
    dataNascimento = (json['dataNascimento'] as Timestamp).toDate();
    endereco = json['endereco'];
    foto = json['foto'];
  }

  factory User.fromFirebase(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return User.fromJson(dados);
  }
}
