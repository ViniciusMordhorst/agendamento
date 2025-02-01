import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  int? id;
  String? nome;
  String? cpf;
  DateTime? dataNascimento;
  String? email;
  String? endereco;
  String? senha;
  String? foto;

  User(this.nome, this.cpf, this.email, this.senha,this.dataNascimento, this.endereco);

   Map<String, dynamic> toFirebase(){
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'senha': senha,
      'dataNascimento': dataNascimento,
      'endereco': endereco,
      if (foto !=null) "foto": foto else "foto": null
    

    };

   }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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









