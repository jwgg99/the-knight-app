import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/carrito_controller.dart';
import '../models/producto.dart';

class DetalleScreen extends StatefulWidget {
  final Producto producto;

  const DetalleScreen({super.key, required this.producto});

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  String? _tallaSeleccionada;

  @override
  void initState() {
    super.initState();

    if (widget.producto.tallas.isNotEmpty) {
      _tallaSeleccionada = widget.producto.tallas.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          if (maxWidth >= 600) {
            // Pantallas anchas: dos columnas
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildImagen(producto),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 1,
                    child: _buildInformacion(context, producto),
                  ),
                ],
              ),
            );
          } else {
            // Pantallas móviles: una columna
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagen(producto),
                  const SizedBox(height: 24),
                  _buildInformacion(context, producto),
                ],
              ),
            );
          }
        },
      ),
    );
  }


  Widget _buildImagen(Producto producto) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              producto.imagenUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image, size: 60, color: Colors.grey),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Información del producto
  Widget _buildInformacion(BuildContext context, Producto producto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          producto.nombre,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        const Text(
          'Marca: The Knight',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const Icon(Icons.star_half, color: Colors.amber, size: 20),
            const SizedBox(width: 8),
            Text(
              '4.5 (128 ventas)',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Text(
          '\$${producto.precio.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          producto.descripcion,
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 24),

        const Text(
          'Opciones',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _tallaSeleccionada,
          decoration: InputDecoration(
            labelText: 'Selecciona una opción',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: producto.tallas.map((talla) {
            return DropdownMenuItem(
              value: talla,
              child: Text(talla),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _tallaSeleccionada = value;
            });
          },
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _tallaSeleccionada == null
                ? null
                : () {
              final carrito =
              Provider.of<CarritoController>(context, listen: false);
              carrito.agregarProducto(
                producto,
                talla: _tallaSeleccionada!,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                  Text('${producto.nombre} añadido al carrito'),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Comprar ahora'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}