
import 'package:ecommerce_clothing_store/blocs/favorites/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded && state.favoriteItems.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else if (state is FavoritesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.favoriteItems.length,
              itemBuilder: (context, index) {
                final product = state.favoriteItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            product.imageUrl,
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
                              Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(product.category, style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 8),
                              Text('\$${product.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(ToggleFavorite(product: product));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No favorites yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
