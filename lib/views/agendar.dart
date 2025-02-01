
import 'dart:developer';


import 'package:agendamento/views/Consultas.dart';
import 'package:agendamento/views/hometab.dart';
import 'package:agendamento/views/hospitais.dart';
import 'package:agendamento/views/medicos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<String> horas = <String>['00', '01', '02','04','05',
'06', '07', '08','09','10',
'11', '12', '13','14','15',
'16', '17', '18','19','20',
'21', '22', '23',];

const List<String> minutos = <String>['00', '01', '02','04','05',
'06', '07', '08','09','10',
'11', '12', '13','14','15',
'16', '17', '18','19','20',
'21', '22', '23','24','25',
'26', '27', '28','29','30','45'];

const List<String> tiposDeConsulta = ['Consulta Geral', 'Pediatria', 'Dermatologia', 'Cardiologia'];


class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}



class _AgendarState extends State<Agendar> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _calendarioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 void _navigateToScreen(Widget telas) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }

  String? _dia;
  String? _minuto;
  String? _hora;
  String? _tipoConsulta;
  String? _retorno;

void _enviarDados() {
  log("Sua consulta foi agendada para:\nData: $_dia\n Hora: $_hora:$_minuto \n Tipo de Consulta: $_tipoConsulta");
}
  Future<void> _salvar() async {
   
  }

  Future<void> _Calendario(BuildContext context) async{
    final DateTime? data = await showDatePicker(
      context:context, 
     firstDate: DateTime(1900), 
     lastDate: DateTime(2100),
     currentDate: DateTime.now(),
     ); //Caixa de alerta que abre o calendario(datepicker)
     if (data!= null) {
      setState(() {
          _calendarioController.text = DateFormat("dd/MM/yyyy").format(data).toString();
      });
       _dia = _calendarioController.text;
     }
  }


  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _calendarioController.dispose();
    _nascimentoController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: const Text("Agendar Consulta"),
          backgroundColor: Colors.blue[400]
      
      ),
      body: SafeArea(child: SingleChildScrollView( //scroll
      padding: const EdgeInsets.all(16), //bordas
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController, //variavel controller textformfield
              decoration: InputDecoration(
            
                hintText: 'Nome',
                filled: true, //preencher campo
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always, 
                border: const OutlineInputBorder(), //borda
              ),
              validator:(value) {
                if (value == null || value.isEmpty) {
                  return 'Campo é obrigatório';
            
                }
                return null;
              },

            ),
            const SizedBox(height: 20.0,),
            TextFormField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone ,
              decoration: InputDecoration(
            
                hintText: 'Telefone',
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(),
              ),
              validator:(value) {
                if (value == null || value.isEmpty) {
                  return 'Campo é obrigatório';
            
                }
                return null;
              },

            ),
            const SizedBox(height: 20.0,),  

            const SizedBox(height: 20.0,),

              RichText(text: const TextSpan(
              style: TextStyle(
                
                color: Colors.black87,
                fontSize: 20,
              ),

              children: [
                TextSpan(
                  text: 'Agora informe a data em que deseja consultar, hora e tipo de atendimento:',
                  
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ), 
                ),
              ],
            ),
            ),
             const SizedBox(height: 20.0,),
            TextFormField(
              controller: _calendarioController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                
                hintText: 'Digite/selecione a data da consulta',
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.blue[600],
                    ),
                    onTap: () => _Calendario(context),
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
                height: 20.0,
              ),
              Text('Selecione um horario'),

             Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: _hora,
          iconEnabledColor: Colors.amber,

          dropdownColor: Colors.blue[50],
          menuMaxHeight: 100,
          items: horas.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _hora = value;
            });
          },
        ),
        const SizedBox(width: 8), 

        Text('/'), 
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: _minuto,
          
          dropdownColor: Colors.blue[50],
          iconEnabledColor: Colors.amber,
          menuMaxHeight: 100,
          items: minutos.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _minuto = value;
            });
          },
        ),

  
  ],
),
  ],
),
const SizedBox(height: 40),
   // Espaçamento entre os DropdownButtons
    Text('Selecione o tipo de consulta'),
    DropdownButton<String>(
    
      value: _tipoConsulta,
      
      hint: const Text('Selecione'),
      dropdownColor: Colors.blue[50],
          iconEnabledColor: Colors.amber,
         
      menuMaxHeight: 200,
      items: tiposDeConsulta.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _tipoConsulta = value;
        });
      },
    ),

                const SizedBox(
                height: 20.0,
                ),
  
              ElevatedButton(
                onPressed: _enviarDados, 
                child: const Text("Enviar", ),
               ), 
               const SizedBox(height: 30.0,),
       

            ],
          ),
        ) ,
      ),
    ),  
    
    bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          // Navegação por índice do BottomNavigationBar
          switch (index) {
            case 0:
              _navigateToScreen(const Hospitais());
              break;
            case 1:
              _navigateToScreen(const Agendar());
              break;
            case 2:
              _navigateToScreen(const Medicos());
              break;
            case 3:
              _navigateToScreen(const Consultas());
              break;
            case 4:
              _navigateToScreen(const Hometab());
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_sharp),
            label: 'Hospitais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp),
            label: 'Agendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_sharp),
            label: 'Médicos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Consultas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
  );
}
}