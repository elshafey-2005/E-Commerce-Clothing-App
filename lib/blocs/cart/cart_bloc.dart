
import 'package:bloc/bloc.dart';
import 'package:ecommerce_clothing_store/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final state = this.state;
      if (state is CartLoaded) {
        final List<CartItem> updatedCart = List.from(state.cartItems);
        final existingIndex = updatedCart.indexWhere((item) => item.product.id == event.product.id);
        if (existingIndex != -1) {
          final newQuantity = updatedCart[existingIndex].quantity + 1;
          updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(quantity: newQuantity);
        } else {
          updatedCart.add(CartItem(product: event.product));
        }
        emit(CartLoaded(cartItems: updatedCart));
      } else {
        emit(CartLoaded(cartItems: [CartItem(product: event.product)]));
      }
    });

    on<RemoveFromCart>((event, emit) {
      final state = this.state;
      if (state is CartLoaded) {
        final List<CartItem> updatedCart = List.from(state.cartItems);
        final existingIndex = updatedCart.indexWhere((item) => item.product.id == event.productId);
        if (existingIndex != -1) {
          if (updatedCart[existingIndex].quantity > 1) {
            final newQuantity = updatedCart[existingIndex].quantity - 1;
            updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(quantity: newQuantity);
          } else {
            updatedCart.removeAt(existingIndex);
          }
        }
        emit(CartLoaded(cartItems: updatedCart));
      }
    });

    on<ClearCart>((event, emit) {
      emit(CartLoaded(cartItems: []));
    });
  }
}
