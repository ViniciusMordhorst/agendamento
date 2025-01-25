
import 'package:agendamento/views/home.dart';

import 'package:flutter/material.dart';
import 'cadastrar.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();

  

}
  

class _TelaLoginState extends State<TelaLogin> {

  
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.blue[400],
      /*appBar: AppBar(
        ),
      
         backgroundColor: Colors.blue[600],
        
      ),*/
         
      body: SafeArea(
        
     
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Agendamento de Consulta Médica',
                textAlign: TextAlign.center,
                style: TextStyle(
                
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                
                ),

                SizedBox(height: 70.0,),
                TextFormField(
                  controller: _cpfController,
                  decoration: InputDecoration(labelText: 'CPF',
                  filled: true,
                   fillColor: Colors.blue[100],
                 
                    border: OutlineInputBorder(),
              ),
              
            ),
            
            SizedBox(height: 30.0,),

            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha',
              filled: true,
                  fillColor: Colors.blue[100],
                border: OutlineInputBorder(),
                ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                
              },
              child: Text('Login'),
            ),
                SizedBox(height: 40),
                Text("Primeiro Acesso?"),
                 ElevatedButton(
                  
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cadastrar()),
                );
              },
              child: Text('Cadastrar'),
            ),
          ],
          
        ),
    ),
    ),
    );
}

}

