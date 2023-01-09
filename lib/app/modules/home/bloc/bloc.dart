import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hubia_menu_app/api/models/category.dart';
import 'package:hubia_menu_app/api/models/dish.dart';
import 'package:hubia_menu_app/api/models/restaurant.dart';
import 'package:hubia_menu_app/api/models/user.dart';
import 'package:hubia_menu_app/api/repositories/home_repository.dart';
import 'package:hubia_menu_app/app/exceptions/api_exception.dart';
import 'package:hubia_menu_app/api/api.dart';
import 'package:hive_flutter/adapters.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final HomeRepository _homeRepository;

  HomeBloc({required HomeRepository repository}) : super(Loading()) {
    this._homeRepository = repository;
    on<LoadingStates>(_loadStates);
    on<HomeInfosLoading>(_loadingHomeInfos);
    on<HomeInfosLoaded>(_loadedHomeInfos);
  }

  _loadStates(event, emit) async {
    Box box = Hive.box("endereco");
    if (box.get("cidade") != null) {
      emit(Loaded(
          user: new User(id: 1, email: "chris"),
          categorys: this._homeRepository.getCategorys(),
          restaurants: this._homeRepository.getRestaurants()));
    } else {
      List<String> stateList = ["São Paulo", "Rio de Janeiro"];
      try {
        //   Map<String, dynamic> response =
        //     await this.addressComponentRepository.getStates();
        // for (Map<String, dynamic> state in response['result']) {
        //   stateList.add(state['estadoSigla']);
        // }
        emit(StateLoaded(stateList: stateList));
      } on ApiException catch (e) {
        emit(ApiError(error: e.message));
      }
    }
  }

  _loadingHomeInfos(event, emit) async {
    emit(Loading());
    event.onFinish();
  }

  _loadedHomeInfos(event, emit) async {
    try {
      emit(Loaded(
          user: new User(id: 1, email: "chris"),
          categorys: this._homeRepository.getCategorys(),
          restaurants: this._homeRepository.getRestaurants()));
    } on ApiException catch (e) {
      emit(ApiError(error: e.message));
    }
  }

  //  _loadStates(LoadStates event, Emitter<AddressComponentState> emit) async {
  //   List<String> stateList = [];
  //   Map<String, dynamic> response =
  //       await this.addressComponentRepository.getStates();
  //   for (Map<String, dynamic> state in response['result']) {
  //     stateList.add(state['estadoSigla']);
  //   }
  //   emit(Loaded(stateList: stateList));
  // }
}
