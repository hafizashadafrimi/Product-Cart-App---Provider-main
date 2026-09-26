import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (cart.cartItems.isNotEmpty)
            IconButton(
              onPressed: () {
                cart.clearCart();
              },
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Clear Cart',
            ),
        ],
      ),
      body: cart.cartItems.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cart.cartItems[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(
                                product.image,
                                style: const TextStyle(fontSize: 40),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      '৳${product.price.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: const Color(0xFF073B4C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cart.decreaseQuantity(product);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),

                                        Text(
                                          '${cart.quantityOf(product)}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            cart.addToCart(product);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  cart.removeFromCart(product);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                _buildCartSummary(context, cart),
              ],
            ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Items', '${cart.totalItems}'),

          const SizedBox(height: 8),

          _buildSummaryRow('Subtotal', '৳${cart.subtotal.toStringAsFixed(2)}'),

          const SizedBox(height: 8),

          _buildSummaryRow('Discount', '৳${cart.discount.toStringAsFixed(2)}'),

          const Divider(height: 24),

          _buildSummaryRow(
            'Final Total',
            '৳${cart.finalTotal.toStringAsFixed(2)}',
            isTotal: true,
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                cart.clearCart();
              },
              icon: const Icon(Icons.delete_sweep_outlined),
              label: const Text('Clear Cart'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF073B4C) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.remove_shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),

            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Add some products to your cart.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
