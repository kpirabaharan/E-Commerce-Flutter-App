import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/cart_item.dart';

final dio = Dio();

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(dynamic product) {
    final existingCartItem = state.firstWhere(
      (element) => element.id == product.id,
      orElse: () => CartItem(
          id: product.id,
          storeId: product.storeId,
          name: product.name,
          price: product.price,
          image: product is CartItem ? product.image : product.images[0],
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
            image: product is CartItem ? product.image : product.images[0],
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
              image: product is CartItem ? product.image : product.images[0],
              quantity: item.quantity + 1);
        } else {
          return item;
        }
      }).toList();
    }
  }

  void removeItem(String productId) {
    final existingCartItem = state.firstWhere(
      (item) => item.id == productId,
    );

    if (existingCartItem.quantity == 1) {
      state = state.where((item) => item.id != productId).toList();
    } else {
      state = state.map((item) {
        if (item.id == productId) {
          return CartItem(
              id: item.id,
              storeId: item.storeId,
              name: item.name,
              price: item.price,
              image: item.image,
              quantity: item.quantity - 1);
        } else {
          return item;
        }
      }).toList();
    }
  }

  void removeBatch(String productId) {
    state = state.where((item) => item.id != productId).toList();
  }

  void clearCart() {
    state = [];
  }

  Future<void> checkout(String storeId) async {
    final body = {
      'orderedProducts': state
          .map((cartItem) => {'productId': cartItem.id, 'quantity': cartItem.quantity})
          .toList(),
      'storeUrl': 'poop'
    };

    try {
      Response response = await dio.post('http://localhost:3000/api/$storeId/checkout', data: body);
      if (response.statusCode == 200) {
        print(response.data);
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          billingDetails: BillingDetails(email: ''),
          paymentIntentClientSecret: response.data['client_secret'],
          merchantDisplayName: 'Poop',
          style: ThemeMode.dark,
        ));
        clearCart();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
