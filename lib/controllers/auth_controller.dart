import 'package:flutter/foundation.dart';
import '../services/database_helper.dart';

class AuthController extends ChangeNotifier {
  Map<String, dynamic>? _usuario;
  bool _autenticado = false;

  Map<String, dynamic>? get usuario => _usuario;
  bool get autenticado => _autenticado;

  Future<String> registrar(String nombre, String correo, String contrasena) async {
    final existe = await DatabaseHelper.correoExiste(correo);
    if (existe) return 'El correo ya está registrado';
    await DatabaseHelper.registrarUsuario(nombre, correo, contrasena);
    return 'Registro exitoso';
  }

  Future<String> iniciarSesion(String correo, String contrasena) async {
    final usuario = await DatabaseHelper.iniciarSesion(correo, contrasena);
    if (usuario != null) {
      _usuario = usuario;
      _autenticado = true;
      notifyListeners();
      return 'ok';
    }
    return 'Credenciales incorrectas';
  }

  void cerrarSesion() {
    _usuario = null;
    _autenticado = false;
    notifyListeners();
  }

  Future<String> recuperarContrasena(
      String correo, String nuevaContrasena) async {
    final existe = await DatabaseHelper.correoExiste(correo);
    if (!existe) return 'El correo no está registrado';
    await DatabaseHelper.actualizarContrasena(correo, nuevaContrasena);
    return 'Contraseña actualizada';
  }
}