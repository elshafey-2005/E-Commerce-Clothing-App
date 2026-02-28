
import 'package:ecommerce_clothing_store/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cartItems.isNotEmpty) {
                return IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to remove all items from the cart?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              context.read<CartBloc>().add(ClearCart());
                              Navigator.of(ctx).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          )
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartItems.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else if (state is CartLoaded) {
            return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView.builder(
                      itemCount: state.cartItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = state.cartItems[index];
                        return CartListItem(cartItem: cartItem);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildPriceRow('Subtotal', '\$${state.totalAmount.toStringAsFixed(2)}'),
                    _buildPriceRow('Shipping Fee', '\$0.00'),
                    const Divider(height: 30),
                    _buildPriceRow('Total', '\$${state.totalAmount.toStringAsFixed(2)}', isTotal: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPriceRow(String title, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.black : Colors.grey),
          ),
          Text(
            price,
            style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final CartItem cartItem;

  const CartListItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              cartItem.product.imageUrl,
              width: 70,
              height: 87,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(cartItem.product.category, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text('\$${cartItem.product.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, size: 20),
                onPressed: () {
                  context.read<CartBloc>().add(RemoveFromCart(productId: cartItem.product.id));
                },
              ),
              Text('${cartItem.quantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 20),
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(product: cartItem.product));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
