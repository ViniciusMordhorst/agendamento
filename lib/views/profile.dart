import 'package:agendamento/views/Medicos.dart';
import 'package:agendamento/views/agendar.dart';
import 'package:agendamento/views/consultas.dart';
import 'package:agendamento/views/home.dart';
import 'package:agendamento/views/hospitais.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _imagem;

  void _navigateToScreen(Widget telas) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
         horizontal: 16),
         child: Column(
          children: [
            Image.asset('assets/gato.png',
            width: 150,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 100.0,),

           
            const SizedBox(height: 20.0,),
            Image.network('https://images.pexels.com/photos/8075320/pexels-photo-8075320.jpeg',
            width: 300,
            loadingBuilder: (context, child, progress){
              return progress == null ? child : const LinearProgressIndicator();

            },
            ),
            const SizedBox(height: 20.0,),
            
           
           
            const SizedBox(height: 10.0,),
            _imagem != null ?
            Image.network(_imagem!,
            loadingBuilder:(context, child, loadingProgress) {
              return loadingProgress == null ? child: const CircularProgressIndicator();
              },
            )
            : Container(),

          ],
         ),
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
              _navigateToScreen(const Home());
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