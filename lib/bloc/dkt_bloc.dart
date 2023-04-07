// ignore_for_file: public_member_api_docs, sort_constructors_first

//state

import 'package:bloc/bloc.dart';

import 'package:driveaustralia/bloc/model/menu_model.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/repository/dkt_repository.dart';
import 'package:flutter/material.dart';

final menuList = [
  MenuList(menu: 'menu 1', icon:Icons.construction),
  MenuList(menu: 'menu 2', icon:Icons.construction),
  MenuList(menu: 'menu 3', icon:Icons.construction),
  MenuList(menu: 'menu 4', icon:Icons.construction),
  MenuList(menu: 'menu 5', icon:Icons.construction),
];

abstract class DktState {}

class DrivingState extends DktState {
  final List<DktModel>? models;
  final DktModel? model;
  final bool isanimation;
  bool? loadingvalue;
  final bool answerSelect;
  final List<MenuList>? menu;
  DrivingState({
    this.models,
    this.loadingvalue,
    this.model,
    this.isanimation = false,
    this.answerSelect = false,
    this.menu,
  });

  DrivingState copyWith({
    List<DktModel>? models,
    DktModel? model,
    bool? isanimation,
    bool? loadingvalue,
    bool? answerSelect,
    List<MenuList>? menu,
  }) {
    return DrivingState(
      models: models ?? this.models,
      model: model ?? this.model,
      isanimation: isanimation ?? this.isanimation,
      loadingvalue: loadingvalue ?? this.loadingvalue,
      answerSelect: answerSelect ?? this.answerSelect,
      menu: menu ?? this.menu,
    );
  }
}

//Event
abstract class DktEvent {}

class FetchDktDataEvent extends DktEvent {}

class WriteDktDataEvent extends DktEvent {}

class SelectAnswerEvent extends DktEvent {}

class ShowRules extends DktEvent {}

class NextQuestion extends DktEvent {}

class PreviousQuestion extends DktEvent {}

class ShowResult extends DktEvent {}

class LoadMenuEvent extends DktEvent {}

//bloc
class DktBloc extends Bloc<DktEvent, DrivingState> {
  DktBloc(super.initialState) {
    final drivingRepo = DktRepoImplement();
    on<FetchDktDataEvent>((event, emit) async {
      List<DktModel> fetchModelData = await drivingRepo.getQuestions();
      // final dktState =
      //     DrivingState(models: fetchModelData, loadingvalue: false);

      emit(DrivingState().copyWith(
        models: fetchModelData,
        loadingvalue: false,
      ));
    });
    on<LoadMenuEvent>((event, emit) {
        emit(DrivingState().copyWith(menu: menuList));
    });
  }
}
