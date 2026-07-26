import 'producto.dart';

const List<Producto> productosDestacados = [
  Producto(
    id: '1',
    nombre: 'Chaqueta de cuero',
    precio: 120000.0,
    imagenUrl: 'assets/chaqueta.jpg',
    categoria: 'Hombre',
    tallas: ['S', 'M', 'L'],
    color: 'Negro',
  ),
  Producto(
    id: '2',
    nombre: 'Vestido floral',
    precio: 85000.0,
    imagenUrl: 'assets/vestido.jpg',
    categoria: 'Mujer',
    tallas: ['XS', 'S', 'M'],
    color: 'Rojo',
  ),
  Producto(
    id: '3',
    nombre: 'Camiseta básica',
    precio: 60000.0,
    imagenUrl: 'assets/camiseta.jpg',
    categoria: 'Unisex',
    tallas: ['S', 'M', 'L', 'XL'],
    color: 'Blanco',
  ),
  Producto(
    id: '4',
    nombre: 'Zapatillas urbanas',
    precio: 95000.0,
    imagenUrl: 'assets/zapatillas.jpg',
    categoria: 'Calzado',
    tallas: ['38', '39', '40', '41'],
    color: 'Azul',
  ),
];