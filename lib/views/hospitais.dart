
import 'package:agendamento/views/agendar.dart';
import 'package:agendamento/views/consultas.dart';
import 'package:agendamento/views/hometab.dart';
import 'package:agendamento/views/medicos.dart';
import 'package:flutter/material.dart';

class Hospitais extends StatefulWidget {
  const Hospitais({super.key});

  @override
  State<Hospitais> createState() => _HospitaisState();
}

class _HospitaisState extends State<Hospitais> {
  final List<String> _hospitais = <String>['Hospital 1'];

  void _navigateToScreen(Widget telas) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }

  void _adicionarItem(){
    setState(() {
    _hospitais.add('Médico ${_hospitais.length + 1}');
    });

  }

  void _removerItem (int index){
    setState(() {
      _hospitais.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hospital excluido com sucesso'),
    duration: Durations.short1,
    ),
    );

  }

  Widget listView(){
    return ListView(
    padding: const EdgeInsets.all(8),
    children: [
      Card(
        color: Colors.amber[100],
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.lightBlueAccent,
          ),
          title: const Text('Hospital 1'),
        ),
      ),
        Card(
        color: Colors.amber[100],
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.lightBlueAccent,
          ),
          title: const Text('Hospital 2'),
        ),
      ),
      Card(
        color: Colors.amber[100],
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.lightBlueAccent,
          ),
       title: const Text('Hospital 3'),
        ),
      ),
      Card(
        color: Colors.amber[100],
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.lightBlueAccent,
          ),
          title: const Text('Hospital 4'),
        ),
      ),
    ],
  );
}
Widget listViewBuilder(){
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: _hospitais.length,
    itemBuilder: (context, index) {
      return Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
          trailing: IconButton(
            onPressed:(){ _removerItem(index);
            },
            icon: const Icon(Icons.delete,
             color: Colors.red,
             ),
            ) ,
          title:Text(_hospitais[index]),
        ),
      );
    },
  );
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blue[400],
      appBar: AppBar(
      backgroundColor: Colors.blue[400],
        title:  const Text('Lista de Hospitais'),
      ),
      body: SafeArea(
        child: listViewBuilder()
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _adicionarItem, 
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