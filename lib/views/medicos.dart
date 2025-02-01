import 'package:agendamento/controller/firestore.dart';
import 'package:agendamento/views/agendar.dart';
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
  final TextEditingController textController = TextEditingController();

  void _navigateToScreen(Widget telas) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }

  void abrirCaixaTF({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // Botão para salvar
          ElevatedButton(
            onPressed: () {
              // Adicionar ou atualizar médico
              if (docID == null) {
                firestoreService.addMedico(textController.text);
              } else {
                firestoreService.updateMedico(docID, textController.text);
              }

              // Limpar campo de texto
              textController.clear();

              // Fechar caixa de diálogo
              Navigator.pop(context);
            },
            child: Text(docID == null ? "Adicionar" : "Atualizar"),
          ),
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
        title: const Text('Lista de Médicos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getMedicoStream(),
        builder: (context, snapshot) {
          // Se tiver dados, exibe a lista de médicos
          if (snapshot.hasData) {
            List listaMedicos = snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaMedicos.length,
              itemBuilder: (context, index) {
                // Pega o documento individual
                DocumentSnapshot document = listaMedicos[index];
                String docID = document.id;

                // Pega os dados do médico
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String medicoNome = data['Nome'];

                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 32,
                      color: Colors.lightBlueAccent,
                    ),
                    title: Text(medicoNome),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botão de update
                        IconButton(
                          onPressed: () => abrirCaixaTF(docID: docID),
                          icon: const Icon(
                            Icons.update,
                            color: Colors.amber,
                          ),
                        ),
                        // Botão de delete
                        IconButton(
                          onPressed: () => firestoreService.deleteMedico(docID),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            // Se não tiver dados, exibe uma mensagem
            return const Center(child: Text("Nenhum médico cadastrado..."));
          }
        },
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
