part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppAuthentic extends AppState {
  final User user;

  AppAuthentic({required this.user});
}

class AppUnauthentic extends AppState {}
