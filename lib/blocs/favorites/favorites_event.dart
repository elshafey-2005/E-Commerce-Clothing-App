
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends FavoritesEvent {
  final Product product;

  const ToggleFavorite({required this.product});

  @override
  List<Object> get props => [product];
}
