// ignore_for_file: public_member_api_docs, sort_constructors_first

//state

import 'package:bloc/bloc.dart';
import 'package:driveaustralia/bloc/model/cateory_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:driveaustralia/bloc/model/menu_model.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:driveaustralia/repository/dkt_repository.dart';
import 'package:driveaustralia/utils/assets_files.dart';

final menuList = [
  MenuList(id: 1, menu: 'All', icon: drivingImage),
  MenuList(id: 2, menu: 'Alcohol and Drugs', icon: alcoholImage),
  MenuList(id: 3, menu: 'Car General', icon: cargeneralImage),
  MenuList(id: 4, menu: 'Driving General', icon: drivingImage),
  MenuList(id: 5, menu: 'Vulnerable Road Users', icon: vulnerableImage),
  MenuList(id: 6, menu: 'Seat Belts', icon: sealtbeltImage),
  MenuList(id: 7, menu: 'Intersections', icon: intersectionImage),
];

abstract class DktState {}

class DrivingState extends DktState {
  final List<DktModel>? models;
  final DktModel? model;
  final List<CategoryModel>? categorys;
  final bool isanimation;
  bool? loadingvalue;
  final bool answerSelect;
  final List<MenuList>? menu;
  DrivingState({
    this.models,
    this.model,
    this.categorys,
    this.isanimation = false,
    this.loadingvalue = false,
    this.answerSelect = false,
    this.menu,
  });

  DrivingState copyWith({
    List<DktModel>? models,
    DktModel? model,
    List<CategoryModel>? categorys,
    bool? isanimation,
    bool? loadingvalue,
    bool? answerSelect,
    List<MenuList>? menu,
  }) {
    return DrivingState(
      models: models ?? this.models,
      model: model ?? this.model,
      categorys: categorys ?? this.categorys,
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
      List<CategoryModel> fetchCategory = await drivingRepo.getCategory();
      // final dktState =
      //     DrivingState(models: fetchModelData, loadingvalue: false);

      emit(DrivingState().copyWith(
        models: fetchModelData,
        loadingvalue: false,
        categorys: fetchCategory,
      ));
    });
    on<LoadMenuEvent>((event, emit) {
      emit(DrivingState().copyWith(menu: menuList));
    });
  }
}