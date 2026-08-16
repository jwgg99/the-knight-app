import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Almacenamiento en memoria para web
  static final List<Map<String, dynamic>> _usuariosMemoria = [];

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    if (kIsWeb) {

      return await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {},
      );
    } else {
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
  }

  static Future<int> registrarUsuario(
      String nombre, String correo, String contrasena) async {
    if (kIsWeb) {
      // Verificar duplicado
      if (_usuariosMemoria.any((u) => u['correo'] == correo)) {
        throw Exception('El correo ya está registrado');
      }
      _usuariosMemoria.add({
        'id': _usuariosMemoria.length + 1,
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
      });
      return 1; // simular inserción exitosa
    } else {
      final db = await database;
      return await db.insert('usuarios', {
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
      });
    }
  }

  static Future<Map<String, dynamic>?> iniciarSesion(
      String correo, String contrasena) async {
    if (kIsWeb) {
      for (final usuario in _usuariosMemoria) {
        if (usuario['correo'] == correo &&
            usuario['contrasena'] == contrasena) {
          return usuario;
        }
      }
      return null;
    } else {
      final db = await database;
      final result = await db.query('usuarios',
          where: 'correo = ? AND contrasena = ?',
          whereArgs: [correo, contrasena]);
      if (result.isNotEmpty) return result.first;
      return null;
    }
  }

  static Future<bool> correoExiste(String correo) async {
    if (kIsWeb) {
      return _usuariosMemoria.any((u) => u['correo'] == correo);
    } else {
      final db = await database;
      final result = await db
          .query('usuarios', where: 'correo = ?', whereArgs: [correo]);
      return result.isNotEmpty;
    }
  }

  static Future<int> actualizarContrasena(
      String correo, String nuevaContrasena) async {
    if (kIsWeb) {
      final index = _usuariosMemoria.indexWhere((u) => u['correo'] == correo);
      if (index >= 0) {
        _usuariosMemoria[index]['contrasena'] = nuevaContrasena;
        return 1;
      }
      return 0;
    } else {
      final db = await database;
      return await db.update('usuarios', {'contrasena': nuevaContrasena},
          where: 'correo = ?', whereArgs: [correo]);
    }
  }
}