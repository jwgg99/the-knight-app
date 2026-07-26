import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/carrito_controller.dart';
import '../models/producto.dart';
import '../models/productos_mock.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos todos los productos mock (podemos tener más)
    final productos = productosDestacados; // luego ampliaremos

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar al carrito
              Navigator.pushNamed(context, '/carrito');
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Barra lateral de filtros (simulada)
          Container(
            width: 100,
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Filtrar por',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                ListTile(
                  dense: true,
                  title: Text('Tops'),
                  leading: Icon(Icons.check_box_outline_blank, size: 18),
                ),
                ListTile(
                  dense: true,
                  title: Text('Pantalones'),
                  leading: Icon(Icons.check_box_outline_blank, size: 18),
                ),
                ListTile(
                  dense: true,
                  title: Text('Vestidos'),
                  leading: Icon(Icons.check_box_outline_blank, size: 18),
                ),
                Divider(),
                Text('Precio',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                // Slider sería más largo; lo dejamos como placeholder
              ],
            ),
          ),
          // Grid de productos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      final carrito =
                      Provider.of<CarritoController>(context, listen: false);
                      carrito.agregarProducto(producto);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${producto.nombre} añadido'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(producto.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                '\$${producto.precio.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Color(0xFF1A237E),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}