import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minmalecommerce/models/product_model.dart';

class Shop extends ChangeNotifier {
  // Products for sale
  List<Product> _shop = [];

  // User cart
  final List<Product> _cart = [];

  Shop() {
    fetchProducts();
  }

  // Get products list
  List<Product> get shop => _shop;

  // Get user cart
  List<Product> get cart => _cart;

  // Add item to cart
  void addToCart({required Product item}) {
    _cart.add(item);
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart({required Product item}) {
    _cart.remove(item);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Fetch products from Firestore
  Future<void> fetchProducts() async {
    final collection = FirebaseFirestore.instance.collection('added_products');

    // Listen for realtime updates
    collection.snapshots().listen((snapshot) {
      _shop = snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          name: data['name'] ?? '',
          price: data['price']?.toDouble() ?? 0.0,
          description: data['description'] ?? '',
          quantity: data['quantity'] ?? 0,
          imagePath: data['imageUrl'] ?? '',
        );
      }).toList();
      notifyListeners();
    });
  }
}
