
part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Product> favoriteItems;

  const FavoritesLoaded({required this.favoriteItems});

  @override
  List<Object> get props => [favoriteItems];
}
