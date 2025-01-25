import 'package:agendamento/controller/firestore.dart';
import 'package:agendamento/views/Agendar.dart';
import 'package:agendamento/views/consultas.dart';
import 'package:agendamento/views/hometab.dart';
import 'package:agendamento/views/hospitais.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Medicos extends StatefulWidget {
  const Medicos({super.key});

  @override
  State<Medicos> createState() => _MedicosState();
}

class _MedicosState extends State<Medicos> {

  final FirestoreService firestoreService = FirestoreService();
  
 
 void _navigateToScreen(Widget telas) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }

  final TextEditingController textController = TextEditingController();
   
void abrirCaixaTF({String? docID}) {
  showDialog(
    context: context,
   builder: (context) => AlertDialog(
    content: TextField(
      controller: textController,
    ),
    actions: [
      //botão salvar
      ElevatedButton(
        onPressed: () {
          // adicionar médico
          if (docID == null) {
          firestoreService.addMedico(textController.text);
          } else {
            firestoreService.updateMedico(docID, textController.text);

          }
          
          //limpar TC
          textController.clear();  
          
          //fechar caixa

          Navigator.pop(context);
                },
       child: Text("Adicionar")),
    ],
      
   ),
   );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blue[400],
      appBar: AppBar(
       backgroundColor: Colors.blue[400],
        title:  const Text('Lista de Médicos'),
      ),
     body: StreamBuilder<QuerySnapshot>(
       stream: firestoreService.getMedicoStream(),
       builder: (context, snapshot) {
          //pega todas as informações, caso tenha
          if (snapshot.hasData){
            List listaMedicos = snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaMedicos.length,
              itemBuilder: (context, index) {
                
                  // pega cada documento individual
                DocumentSnapshot document = listaMedicos[index];
                String docID = document.id;

                  //pega cada medico de cada documento
                Map<String, dynamic> data =
                 document.data() as Map<String, dynamic>;

                 String medicoNome = data['Nome'];
                  //mostra o listtile

                  return ListTile(
                    title: Text(medicoNome),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min ,
                      children: [
                      //botão de update
                      IconButton(onPressed: () => abrirCaixaTF(docID: docID),
                        icon: const Icon(Icons.update, color: Colors.amber,),
                    ),

                    IconButton(onPressed: () => firestoreService.deleteMedico(docID),
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    ),
                  ],
                ),
              );
            },
          );
        } 
          
          // se não tem data retorna null
          else {
            return const Text("Nenhum médico cadastrado...");
          }
        }
       ),
        floatingActionButton: FloatingActionButton(
          onPressed: abrirCaixaTF, 
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
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