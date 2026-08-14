import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/productos_mock.dart';
import 'detalle_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String _categoriaSeleccionada = 'Todas';

  @override
  Widget build(BuildContext context) {
    // Obtener todas las categorías disponibles
    final categorias = [
      'Todas',
      ...productosDestacados.map((p) => p.categoria).toSet().toList(),
    ];

    // Filtrar productos según la categoría seleccionada
    final productosFiltrados = _categoriaSeleccionada == 'Todas'
        ? productosDestacados
        : productosDestacados
        .where((p) => p.categoria == _categoriaSeleccionada)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        actions: [
          // Selector de categoría (filtro)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _categoriaSeleccionada,
                icon: const Icon(Icons.filter_list, color: Colors.white),
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    _categoriaSeleccionada = value!;
                  });
                },
                items: categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
              ),
            ),
          ),
          // Icono de carrito
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/carrito');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Definir número de columnas según el ancho de la pantalla
          int crossAxisCount;
          if (constraints.maxWidth >= 900) {
            crossAxisCount = 4;      // Pantallas grandes (web/escritorio)
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 3;      // Tablets o web medianas
          } else {
            crossAxisCount = 2;      // Móviles
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.65,   // Misma proporción que Home/Carrito
            ),
            itemCount: productosFiltrados.length,
            itemBuilder: (context, index) {
              final producto = productosFiltrados[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Navegar a detalle (igual que en Home)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleScreen(producto: producto),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen superior
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.asset(
                            producto.imagenUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.image,
                                      size: 40, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Información
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto.nombre,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${producto.precio.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF1A237E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}