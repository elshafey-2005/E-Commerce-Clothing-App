
part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  const CartLoaded({required this.cartItems});

  @override
  List<Object> get props => [cartItems];

  double get totalAmount {
    var total = 0.0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
