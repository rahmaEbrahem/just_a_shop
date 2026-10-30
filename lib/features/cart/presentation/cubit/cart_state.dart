import 'package:e_commerce_app/features/cart/presentation/data/model/cart_model.dart';

abstract class CartState {}


class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartModel> items;
  final double total;
  CartUpdated(this.items, this.total);
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}