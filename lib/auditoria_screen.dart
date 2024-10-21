import 'package:flutter/material.dart';
import 'utils/database_helper.dart';

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  List<Map<String, dynamic>> _auditorias = [];
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadAuditorias();
  }

  Future<void> _loadAuditorias() async {
    final data = await dbHelper.getAcciones();
    setState(() {
      _auditorias = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Auditoría'),
      ),
      body: ListView.builder(
        itemCount: _auditorias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Acción: ${_auditorias[index]['accion']}'),
          );
        },
      ),
    );
  }
}
