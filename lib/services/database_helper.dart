import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'the_knight.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            correo TEXT NOT NULL UNIQUE,
            contrasena TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Registrar usuario
  static Future<int> registrarUsuario(
      String nombre, String correo, String contrasena) async {
    final db = await database;
    return await db.insert('usuarios', {
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    });
  }

  // Iniciar sesión
  static Future<Map<String, dynamic>?> iniciarSesion(
      String correo, String contrasena) async {
    final db = await database;
    final result = await db.query('usuarios',
        where: 'correo = ? AND contrasena = ?', whereArgs: [correo, contrasena]);
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // Verificar si el correo ya está registrado
  static Future<bool> correoExiste(String correo) async {
    final db = await database;
    final result =
    await db.query('usuarios', where: 'correo = ?', whereArgs: [correo]);
    return result.isNotEmpty;
  }

  // Actualizar contraseña
  static Future<int> actualizarContrasena(
      String correo, String nuevaContrasena) async {
    final db = await database;
    return await db.update('usuarios', {'contrasena': nuevaContrasena},
        where: 'correo = ?', whereArgs: [correo]);
  }
}