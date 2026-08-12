import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/carrito_controller.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/catalogo_screen.dart';
import 'views/carrito_screen.dart';
import 'views/registro_screen.dart';
import 'views/recuperar_screen.dart';

void main() {
  runApp(const TheKnightApp());
}

class TheKnightApp extends StatelessWidget {
  const TheKnightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarritoController()),
        ChangeNotifierProvider(create: (context) => AuthController()),
      ],
      child: MaterialApp(
        title: 'The Knight',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1A237E),
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/registro': (context) => const RegistroScreen(),
          '/recuperar': (context) => const RecuperarScreen(),
          '/': (context) => const HomeScreen(),
          '/catalogo': (context) => const CatalogoScreen(),
          '/carrito': (context) => const CarritoScreen(),
        },
      ),
    );
  }
}