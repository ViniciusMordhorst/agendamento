import 'package:agendamento/model/notificacao.dart';
import 'package:agendamento/views/Consultas.dart';
import 'package:agendamento/views/agendar.dart';
import 'package:agendamento/views/hometab.dart';
import 'package:agendamento/views/hospitais.dart';
import 'package:agendamento/views/medicos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificacoesTela extends StatefulWidget {
  const NotificacoesTela({super.key});

  @override
  _NotificacoesTelaState createState() => _NotificacoesTelaState();
}

class _NotificacoesTelaState extends State<NotificacoesTela> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Inicializando o timezone
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // Ícone de notificação

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _navigateToScreen(Widget telas) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => telas),
    );
  }

  // Carregar notificações agendadas do Firestore
  Future<List<Notificacao>> _loadNotificacoes() async {
    try {
      final agendamentos = await FirebaseFirestore.instance.collection('Agendamentos').get();
      List<Notificacao> notificacoes = [];

      for (var doc in agendamentos.docs) {
        final data = doc['data']; // A data e hora devem estar em formato String
        final hora = doc['hora']; // Hora da consulta (string como 'HH:mm')
        final tipo = doc['tipo']; // Tipo da consulta (consulta geral, pediatria etc.)

        final dataConsulta = DateFormat("dd/MM/yyyy").parse(data);
        final horaConsulta = DateFormat("HH:mm").parse(hora);
        final horarioConsulta = DateTime(
          dataConsulta.year,
          dataConsulta.month,
          dataConsulta.day,
          horaConsulta.hour,
          horaConsulta.minute,
        );

        final notificacaoHorario = horarioConsulta.subtract(Duration(minutes: 30));

        // Adiciona a notificação à lista
        notificacoes.add(Notificacao(
          titulo: tipo,
          corpo: 'Sua consulta está agendada para ${DateFormat('HH:mm').format(horarioConsulta)}.',
          horario: notificacaoHorario,
        ));

        // Agendar a notificação para 30 minutos antes da consulta
        _agendarNotificacao(notificacaoHorario, tipo);
      }

      return notificacoes;
    } catch (e) {
      print('Erro ao carregar notificações: $e');
      return [];
    }
  }

  // Função para agendar a notificação
  Future<void> _agendarNotificacao(DateTime horario, String tipoConsulta) async {
    try {
      // Obter o fuso horário local
      final location = tz.getLocation('America/Sao_Paulo'); // Ajuste para seu fuso horário
      final tzHorario = tz.TZDateTime.from(horario, location);

      final androidDetails = AndroidNotificationDetails(
        'consulta_id',
        'Consulta Agendada',
        importance: Importance.max,
        priority: Priority.high,
      );

      final notificationDetails = NotificationDetails(android: androidDetails);

      // Agendar a notificação para 30 minutos antes
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Consulta Agendada',
        'Lembre-se da sua consulta de $tipoConsulta às ${DateFormat('HH:mm').format(horario)}.',
        tzHorario,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Erro ao agendar notificação: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações Agendadas'),
      ),
      body: FutureBuilder<List<Notificacao>>(
        future: _loadNotificacoes(), // Carregar notificações assíncronas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar notificações: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma notificação agendada.'));
          }

          List<Notificacao> notificacoes = snapshot.data!;

          return ListView.builder(
            itemCount: notificacoes.length,
            itemBuilder: (context, index) {
              Notificacao notificacao = notificacoes[index];
              String horarioFormatado =
                  DateFormat('dd/MM/yyyy HH:mm').format(notificacao.horario);
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(notificacao.titulo),
                  subtitle: Text(notificacao.corpo),
                  trailing: Text(horarioFormatado),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
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
