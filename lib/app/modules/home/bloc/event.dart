part of 'bloc.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingStates extends HomeEvent {}

class HomeInfosLoaded extends HomeEvent {
  final String uf;
  final String cidade;
  HomeInfosLoaded({required this.uf, required this.cidade});

  @override
  List<Object> get props => [uf, cidade];
}

class HomeInfosLoading extends HomeEvent {
  final List<String> stateList;
  final Function onFinish;
  HomeInfosLoading({required this.stateList, required this.onFinish});

  @override
  List<Object> get props => [stateList, onFinish];
}
