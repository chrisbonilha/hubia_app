part of 'bloc.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends HomeState {}

class Loading extends HomeState {
  final List<String>? stateList;
  Loading({
    this.stateList,
  });

  @override
  List<Object> get props => [];
}

class StateLoaded extends HomeState {
  final List<String> stateList;

  StateLoaded({required this.stateList});

  @override
  List<Object> get props => [stateList];
}

class ApiError extends HomeState {
  final String error;

  ApiError({required this.error});
}

class Loaded extends HomeState {
  final User user;
  final List<Category> categorys;
  final List<Restaurant> restaurants;
  final String? uf;
  final String? city;

  Loaded(
      {required this.user,
      required this.categorys,
      required this.restaurants,
      this.uf,
      this.city});

  @override
  List<Object> get props => [
        user,
        categorys,
        restaurants,
      ];
}
