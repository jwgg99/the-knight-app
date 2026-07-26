import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/carrito_controller.dart';
import 'views/home_screen.dart';
import 'views/catalogo_screen.dart';
import 'views/carrito_screen.dart';

void main() {
  runApp(const TheKnightApp());
}

class TheKnightApp extends StatelessWidget {
  const TheKnightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarritoController(),
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
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/catalogo': (context) => const CatalogoScreen(),
          '/carrito': (context) => const CarritoScreen(),
        },
      ),
    );
  }
}