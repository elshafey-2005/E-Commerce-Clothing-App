
import 'package:bloc/bloc.dart';
import 'package:ecommerce_clothing_store/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<ToggleFavorite>((event, emit) {
      final state = this.state;
      if (state is FavoritesLoaded) {
        final List<Product> updatedFavorites = List.from(state.favoriteItems);
        if (updatedFavorites.any((item) => item.id == event.product.id)) {
          updatedFavorites.removeWhere((item) => item.id == event.product.id);
        } else {
          updatedFavorites.add(event.product);
        }
        emit(FavoritesLoaded(favoriteItems: updatedFavorites));
      } else {
        emit(FavoritesLoaded(favoriteItems: [event.product]));
      }
    });
  }

  bool isFavorite(Product product) {
    final state = this.state;
    if (state is FavoritesLoaded) {
      return state.favoriteItems.any((item) => item.id == product.id);
    }
    return false;
  }
}
