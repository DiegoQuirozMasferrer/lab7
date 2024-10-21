import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auditoria_screen.dart';
import 'preferencias_screen.dart';
import 'utils/database_helper.dart';  // Para la base de datos
import 'auditoria.dart';  // Para la clase Auditoria

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = '';  // Variable para el nombre de usuario
  int _counter = 0;       // Variable para el contador
  final dbHelper = DatabaseHelper();  // Instancia para gestionar la base de datos

  @override
  void initState() {
    super.initState();
    _loadPreferences();  // Cargar las preferencias cuando se inicie la pantalla
  }

  // Método para cargar las preferencias guardadas desde SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Usuario';  // Si no hay valor, usar "Usuario"
      _counter = prefs.getInt('counter') ?? 0;  // Si no hay valor, usar 0
    });
    print('Nombre cargado: $_userName, Contador cargado: $_counter');  // Debugging
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú de navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Preferencias'),
              onTap: () async {
                // Navega a la pantalla de preferencias y actualiza al regresar
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreferenciasScreen()),
                );
                _loadPreferences();  // Recarga las preferencias al volver
                // Registrar la acción en la base de datos usando insertAccion
                await dbHelper.insertAccion('Navegó a Preferencias');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Auditoría'),
              onTap: () async {
                // Navega a la pantalla de auditoría
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuditoriaScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola $_userName',  // Mostrar el nombre de usuario cargado
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),  // Un espacio entre los textos
            Text(
              'Contador: $_counter',  // Mostrar el contador cargado
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
