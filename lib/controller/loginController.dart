import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Logincontroller {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para validar CPF e senha
  Future<bool> validarLogin(String cpf, String senha) async {
    try {
      // Buscar o usuário no banco com o CPF
      QuerySnapshot querySnapshot = await _db
          .collection('Usuario') 
          .where('cpf', isEqualTo: cpf)
          .limit(1) // Garantir que só retornará um documento
          .get();

      // Verificar se encontramos o usuário
      if (querySnapshot.docs.isNotEmpty) {
        // Pegue o primeiro (e único) documento retornado
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        
        // Verificar se a senha fornecida corresponde à senha armazenada no banco
        String senhaSalva = userDoc['senha'];

        if (senhaSalva == senha) {
          // Se as senhas coincidirem, login bem-sucedido
          return true;
        } else {
          // Senha incorreta
          return false;
        }
      } else {
        // Usuário não encontrado
        return false;
      }
    } catch (e) {
      print("Erro ao validar login: $e");
      return false;
    }
  }
}
