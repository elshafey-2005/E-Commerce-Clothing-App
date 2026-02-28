
import 'package:ecommerce_clothing_store/blocs/favorites/favorites_bloc.dart';
import 'package:ecommerce_clothing_store/models/product_model.dart';
import 'package:ecommerce_clothing_store/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<Product> products = [
      Product(id: '1', name: 'Modern Light Clothes', category: 'T-Shirt', imageUrl: 'assets/image/Product 1 (1).png', price: 212.99, rating: 5.0),
      Product(id: '2', name: 'Light Dress Bless', category: 'Dress modern', imageUrl: 'assets/image/Product 2 (1).png', price: 162.99, rating: 5.0),
      Product(id: '3', name: 'Another Dress', category: 'Dress', imageUrl: 'assets/image/Product 3.png', price: 199.99, rating: 4.8),
      Product(id: '4', name: 'Cool T-Shirt', category: 'T-Shirt', imageUrl: 'assets/image/Product 4.png', price: 89.99, rating: 4.9),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Welcome 👋',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Mohamed Elshafiey',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/image/profile.jpeg'),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search clothes...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Categories
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(label: 'All Items', icon: Icons.widgets_outlined, isSelected: true),
                    CategoryChip(label: 'Dress', icon: Icons.local_mall_outlined, isSelected: false),
                    CategoryChip(label: 'T-Shirt', icon: Icons.style_outlined, isSelected: false),
                    CategoryChip(label: 'Pants', icon: Icons.boy_outlined, isSelected: false),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Product Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const CategoryChip({Key? key, required this.label, required this.icon, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: isSelected ? Colors.white : Colors.black),
          if (isSelected) SizedBox(width: 8),
          if (isSelected) Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    bool isFavorite = favoritesBloc.isFavorite(product);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: product.id,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    favoritesBloc.add(ToggleFavorite(product: product));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        if (state is FavoritesLoaded) {
                          isFavorite = state.favoriteItems.any((item) => item.id == product.id);
                        }
                        return Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 16,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(product.category, style: TextStyle(fontSize: 14, color: Colors.grey)),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${product.price}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('${product.rating}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
