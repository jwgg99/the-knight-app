import 'package:flutter/foundation.dart';
import '../models/producto.dart';

// Un elemento dentro del carrito (producto + cantidad + talla elegida)
class ItemCarrito {
  final Producto producto;
  int cantidad;
  String tallaSeleccionada;

  ItemCarrito({
    required this.producto,
    this.cantidad = 1,
    this.tallaSeleccionada = 'M',
  });

  double get subtotal => producto.precio * cantidad;
}

//Controlador que maneja el estado del carrito
class CarritoController extends ChangeNotifier {
  final List<ItemCarrito> _items = [];

  List<ItemCarrito> get items => List.unmodifiable(_items);

  // Total de artículos
  int get cantidadTotal =>
      _items.fold(0, (sum, item) => sum + item.cantidad);

  // Suma de subtotales
  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.subtotal);

  // Impuestos 19%
  double get impuestos => subtotal * 0.19;

  // Total a pagar
  double get total => subtotal + impuestos;

  // Añadir producto al carrito
  void agregarProducto(Producto producto, {String talla = 'M'}) {
    // Buscar si ya existe el producto con la misma talla
    final index = _items.indexWhere(
          (item) => item.producto.id == producto.id && item.tallaSeleccionada == talla,
    );

    if (index >= 0) {
      // Si ya existe
      _items[index].cantidad++;
    } else {
      // Si no, lo añadimos nuevo
      _items.add(ItemCarrito(
        producto: producto,
        tallaSeleccionada: talla,
      ));
    }
    notifyListeners(); //
  }

  // Quitar una unidad o eliminar si llega a 0
  void disminuirCantidad(Producto producto, {String talla = 'M'}) {
    final index = _items.indexWhere(
          (item) => item.producto.id == producto.id && item.tallaSeleccionada == talla,
    );
    if (index >= 0) {
      if (_items[index].cantidad > 1) {
        _items[index].cantidad--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Eliminar completamente un producto del carrito
  void eliminarProducto(Producto producto, {String talla = 'M'}) {
    _items.removeWhere(
          (item) => item.producto.id == producto.id && item.tallaSeleccionada == talla,
    );
    notifyListeners();
  }

  // Vaciar carrito
  void vaciar() {
    _items.clear();
    notifyListeners();
  }
}