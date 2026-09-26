import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];

  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Product> get cartItems => List.unmodifiable(_cartItems);

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  int get totalItems => _cartItems.length;

  int quantityOf(Product product) {
    return _cartItems.where((item) => item.id == product.id).length;
  }

  double get subtotal {
    double total = 0;

    for (final product in _cartItems) {
      total += product.price;
    }

    return total;
  }

  double get discount {
    if (subtotal > 2000) {
      return subtotal * 0.10;
    }

    return 0;
  }

  double get finalTotal {
    return subtotal - discount;
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    final index = _cartItems.lastIndexWhere((item) => item.id == product.id);

    if (index != -1) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Product> filterProducts(List<Product> products) {
    return products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}
