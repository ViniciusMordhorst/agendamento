import 'dart:developer';


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
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

/* final _db = DBController();*/
User? _user;

  void _salvarForm() async{
  final bool isValid = _formKey.currentState?.validate() ?? false;
  final navigator = Navigator.of(context);

 if(isValid){
    if (_user == null) {
       /*  await _db.salvarUsuario(
        User(_nomeController.text,
         _cpfController.text,
          _emailController.text,
          _enderecoController.text,
            _senhaController.text),

      );*/

    } else {
      
    }
    navigator.pop();
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
          _nascimentoController.text = DateFormat("dd/MM/yyyy").format(data).toString();

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
              controller: _nascimentoController,
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