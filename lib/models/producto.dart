class Producto {
  final String id;
  final String nombre;
  final double precio;
  final String imagenUrl;
  final String categoria;
  final List<String> tallas;
  final String color;

  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
    required this.categoria,
    required this.tallas,
    required this.color,
  });
}