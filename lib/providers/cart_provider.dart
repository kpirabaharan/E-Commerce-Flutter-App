import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final existingCartItem = state.firstWhere(
      (element) => element.id == product.id,
      orElse: () => CartItem(
          id: product.id,
          storeId: product.storeId,
          name: product.name,
          price: product.price,
          image: product.images[0],
          quantity: 0),
    );

    if (existingCartItem.quantity == 0) {
      state = [
        ...state,
        CartItem(
            id: product.id,
            storeId: product.storeId,
            name: product.name,
            price: product.price,
            image: product.images[0],
            quantity: 1)
      ];
    } else {
      state = state.map((item) {
        if (item.id == product.id) {
          return CartItem(
              id: item.id,
              storeId: item.storeId,
              name: item.name,
              price: item.price,
              image: item.image,
              quantity: item.quantity + 1);
        } else {
          return item;
        }
      }).toList();
    }
  }

  void removeFromCart(String productId) {
    state = state.where((id) => id != productId).toList();
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
