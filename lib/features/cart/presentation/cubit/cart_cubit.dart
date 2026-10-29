import 'package:e_commerce_app/features/cart/presentation/data/model/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartModel> _items = [];

  List<CartModel> get items => List.unmodifiable(_items);

  void getCartItems() {
      print('getCartItems on cubit: ${identityHashCode(this)}');
    _emitCartUpdated();
  }

  void addItem(CartModel product) {
     print('addItem on cubit: ${identityHashCode(this)}');
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _items[index].quantity =
          (_items[index].quantity ?? 1) + (product.quantity ?? 1);
    } else {
      product.quantity = product.quantity ?? 1;
      _items.add(product);
    }
    _emitCartUpdated();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    _emitCartUpdated();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index].quantity = quantity;
      _emitCartUpdated();
    }
  }

  Future<void> simulateCheckout() async {
    if (_items.isEmpty) return;

    emit(CartLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    _items.clear();
    emit(CartSuccess());      
    _emitCartUpdated();      
  }

  double calculateTotal() {
    return _items.fold(
      0.0,
      (sum, item) => sum + ((item.price ?? 0.0) * (item.quantity ?? 1)),
    );
  }

  void _emitCartUpdated() {
    emit(CartUpdated(List.from(_items), calculateTotal()));
  }
}