import 'package:flutter/material.dart';
import 'package:lab7persistencia/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/database_helper.dart';
import 'auditoria.dart';

class PreferenciasScreen extends StatefulWidget {
  @override
  _PreferenciasScreenState createState() => _PreferenciasScreenState();
}

class _PreferenciasScreenState extends State<PreferenciasScreen> {
  String _userName = '';
  int _counter = 0;
  final dbHelper = DatabaseHelper();  // Para registrar acciones en la base de datos

  @override
  void initState() {
    super.initState();
    _loadPreferences();  // Cargar las preferencias cuando se inicie la pantalla
  }

  // Método para cargar las preferencias desde SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _counter = prefs.getInt('counter') ?? 0;


    });
  }

  // Método para guardar las preferencias en SharedPreferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setInt('counter', _counter);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()
        )
    ).then((_) {

      _loadPreferences();
    });

    // Registrar la acción en la base de datos usando insertAccion
    await dbHelper.insertAccion('Guardó preferencias: $_userName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            Slider(
              value: _counter.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: _counter.toString(),
              onChanged: (value) {
                setState(() {
                  _counter = value.toInt();
                });
              },
            ),
            ElevatedButton(
              onPressed: _savePreferences,
              child: Text('Guardar preferencias'),
            ),
          ],
        ),
      ),
    );
  }
}
