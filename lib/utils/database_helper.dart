import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'auditoria.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE auditoria(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        accion TEXT
      )
    ''');
  }

  // Función para insertar una acción en la tabla auditoría
  Future<int> insertAccion(String accion) async {
    final db = await database;
    return await db.insert('auditoria', {'accion': accion});
  }

  // Función para obtener todas las acciones de la tabla auditoría
  Future<List<Map<String, dynamic>>> getAcciones() async {
    final db = await database;
    return await db.query('auditoria');
  }
}
