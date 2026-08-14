import 'package:flutter/material.dart';

class SeguimientoScreen extends StatefulWidget {
  const SeguimientoScreen({super.key});

  @override
  State<SeguimientoScreen> createState() => _SeguimientoScreenState();
}

class _SeguimientoScreenState extends State<SeguimientoScreen> {
  int _pasoActual = 0;
  final List<String> _estados = [
    'En preparación',
    'En camino',
    'Entregado',
  ];

  void _avanzarEstado() {
    if (_pasoActual < _estados.length - 1) {
      setState(() {
        _pasoActual++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento del Pedido'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Estado actual de tu pedido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Stepper(
              currentStep: _pasoActual,
              onStepTapped: (index) {},
              controlsBuilder: (context, details) {
                return const SizedBox.shrink();
              },
              steps: _estados
                  .map((estado) => Step(
                title: Text(estado),
                content: Text(
                  _pasoActual == _estados.indexOf(estado)
                      ? 'Actualmente: $estado'
                      : '',
                ),
                isActive: _estados.indexOf(estado) <= _pasoActual,
                state: _estados.indexOf(estado) < _pasoActual
                    ? StepState.complete
                    : _estados.indexOf(estado) == _pasoActual
                    ? StepState.editing
                    : StepState.indexed,
              ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            if (_pasoActual < _estados.length - 1)
              ElevatedButton(
                onPressed: _avanzarEstado,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simular avance de estado'),
              )
            else
              const Text('¡Pedido entregado!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
          ],
        ),
      ),
    );
  }
}