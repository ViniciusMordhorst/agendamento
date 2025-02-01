import 'dart:developer';


import 'package:agendamento/controller/UserDBController.dart';
import 'package:agendamento/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:agendamento/controller/DBController';

class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 final UserDBcontroller userdbcontroller = UserDBcontroller();
User? usuario;

void _salvarForm() async {
  final bool isValid = _formKey.currentState?.validate() ?? false;
  final navigator = Navigator.of(context);

  if (isValid) {
    try {
      // Convertendo a string da data para DateTime antes de salvar
      DateTime? dataNascimento;
      if (_dataNascimentoController.text.isNotEmpty) {
        dataNascimento = DateFormat("dd/MM/yyyy").parse(_dataNascimentoController.text);
      }

      // Criando uma instância do usuário
    User novoUsuario = User(
      _nomeController.text,
      _cpfController.text,
      _emailController.text,
      _senhaController.text, // Corrigido: senha antes de dataNascimento
      dataNascimento, // Corrigido: passando DateTime, não String
      _enderecoController.text,
);


      // Salvando no banco de dados
      await userdbcontroller.adicionarUsuario(novoUsuario);

      // Exibir mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuário cadastrado com sucesso!"))
      );

      // Fechar a tela de cadastro
      navigator.pop();
    } catch (e) {
      // Exibir mensagem de erro em caso de falha
      print("Erro ao salvar usuário: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar usuário. Tente novamente."))
      );
    }
  }
}

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _enderecoController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _abrirCalendario(BuildContext context) async{
    final DateTime? data = await showDatePicker(
      context:context, 
     firstDate: DateTime(1900), 
     lastDate: DateTime(2100),
     currentDate: DateTime.now(),
     ); //Caixa de alerta que abre o calendario(datepicker)
     if (data!= null) {
      setState(() {
          _dataNascimentoController.text = DateFormat("dd/MM/yyyy").format(data).toString();

      });
       
     }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         backgroundColor: Colors.blue[400],
           appBar: AppBar(
              title: Text('Cadastrar'),
                backgroundColor: Colors.blue[400],
          ),
        body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              SizedBox(
                height: 50.0,),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    TextFormField(
             
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite seu nome',
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo é obrigatório';
                        }
                        log("Nome: ${_nomeController.text}");
                        return null;
                        
                      },
                    ),
                     const SizedBox(
                      height: 30.0,
                    ),  
                     TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite seu CPF',
                        labelText: 'CPF',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo é obrigatório';
                        }
                        log("CPF: ${_cpfController.text}");
                        return null;
                        
                      },
                    ),
                     const SizedBox(
                      height: 30.0,
                    ),  

                    TextFormField(
              controller: _dataNascimentoController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
               labelText: 'Data de Nascimento',
                hintText: 'Data de Nascimento',
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                     color: Colors.blue[600],
                    ),
                    onTap: () => _abrirCalendario(context),
                ), //calendario GestureDetector(coloca clique)
              ),
              validator:(value) {
                if (value == null || value.isEmpty) {
                  return 'Campo é obrigatório';
            
                }
                return null;
              },

            ),
            
                  const SizedBox(
                      height: 30.0,
                    ),  

                     TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite seu email',
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo é obrigatório';
                        }
                        log("Email: ${_emailController.text}");
                        return null;
                        
                      },
                    ),
                       const SizedBox(
                      height: 30.0,
                    ),  
                     TextFormField(
                      controller: _enderecoController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite seu endereço',
                        labelText: 'Bairro',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo é obrigatório';
                        }
                        log("Endereço: ${_enderecoController.text}");
                        return null;
                        
                      },
                    ),

                    
                      const SizedBox(
                      height: 30.0,
                    ),          
                     TextFormField(
                      controller: _senhaController,
                      decoration: const InputDecoration(
                        
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Digite uma senha',
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Este campo é obrigatório';
                        }
                        log("Senha: ${_senhaController.text}");
                        return null;
                        
                      },
                    ),
                    
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(onPressed: _salvarForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white70,
                      
                     
                    ),
                     child: const Text ("Enviar"),
                  
                    ),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}