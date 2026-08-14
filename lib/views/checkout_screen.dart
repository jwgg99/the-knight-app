import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/carrito_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _metodoPago = 'contra_entrega';

  void _confirmarPedido() {
    final carrito = Provider.of<CarritoController>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pedido Confirmado'),
        content: Text(
          'Tu pedido por \$${carrito.total.toStringAsFixed(2)} ha sido recibido.\n'
              'Método de pago: ${_metodoPago == 'contra_entrega' ? 'Contra entrega' : 'Pago digital'}\n'
              'Recibirás una notificación cuando esté listo.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              carrito.vaciar();
              Navigator.of(context).pop(); // cerrar diálogo
              Navigator.of(context).pop(); // volver al carrito
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Pedido'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Resumen del pedido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: carrito.items.length,
                itemBuilder: (context, index) {
                  final item = carrito.items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.producto.nombre),
                    subtitle: Text(
                        'Talla: ${item.tallaSeleccionada} x${item.cantidad}'),
                    trailing: Text(
                        '\$${(item.producto.precio * item.cantidad).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('\$${carrito.subtotal.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Impuestos (15%)'),
                Text('\$${carrito.impuestos.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('\$${carrito.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1A237E))),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Método de pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Contra entrega'),
              value: 'contra_entrega',
              groupValue: _metodoPago,
              onChanged: (value) {
                setState(() {
                  _metodoPago = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Pago digital'),
              value: 'digital',
              groupValue: _metodoPago,
              onChanged: (value) {
                setState(() {
                  _metodoPago = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: carrito.items.isEmpty ? null : _confirmarPedido,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Confirmar Pedido',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}