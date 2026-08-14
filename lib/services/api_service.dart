import '../models/producto.dart';
import '../models/productos_mock.dart';

class ApiService {
  // Simular GET /productos
  static Future<List<Producto>> fetchProductos() async {
    await Future.delayed(const Duration(seconds: 1));
    return productosDestacados;
  }

  // Simular GET /productos/{id}
  static Future<Producto?> fetchProducto(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (final p in productosDestacados) {
      if (p.id == id) return p;
    }
    return null;
  }

  // Simular POST /pedidos
  static Future<Map<String, dynamic>> confirmarPedido(
      Map<String, dynamic> pedidoData) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'success': true,
      'mensaje': 'Pedido confirmado',
      'pedidoId': DateTime.now().millisecondsSinceEpoch.toString(),
      ...pedidoData,
    };
  }
}