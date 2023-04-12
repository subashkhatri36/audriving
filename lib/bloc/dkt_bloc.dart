// ignore_for_file: public_member_api_docs, sort_constructors_first

//state

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:driveaustralia/bloc/model/cateory_model.dart';
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
  MenuList(id: 8, menu: 'About Developer', icon: meImage),
];

abstract class DktState {}

class DrivingState extends DktState {
  final List<DktModel>? modelList;
  final DktModel? model;
  final List<CategoryModel>? categorys;
  final bool loadingvalue;
  final bool answerSelect;
  final int selectedIndex;
  final List<MenuList>? menu;
  final int index;

  DrivingState({
    this.modelList,
    this.model,
    this.categorys,
    this.loadingvalue = false,
    this.answerSelect = false,
    this.selectedIndex = -1,
    this.menu,
    this.index = 0,
  });

  DrivingState copyWith({
    List<DktModel>? modelList,
    DktModel? model,
    List<CategoryModel>? categorys,
    bool? loadingvalue,
    bool? answerSelect,
    int? selectedIndex,
    List<MenuList>? menu,
    int? index,
  }) {
    return DrivingState(
        modelList: modelList ?? this.modelList,
        model: model ?? this.model,
        categorys: categorys ?? this.categorys,
        loadingvalue: loadingvalue ?? this.loadingvalue,
        answerSelect: answerSelect ?? this.answerSelect,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        menu: menu ?? this.menu,
        index: index ?? this.index);
  }
}

//Event
abstract class DktEvent {}

class FetchDktDataEvent extends DktEvent {}

class WriteDktDataEvent extends DktEvent {}

class SelectAnswerEvent extends DktEvent {}

class ShowRules extends DktEvent {}

class NextQuestion extends DktEvent {
  final List<DktModel> modelList;
  final int index;

  NextQuestion(this.modelList, this.index);
}

class PreviousQuestion extends DktEvent {
  final List<DktModel> modelList;
  final int index;

  PreviousQuestion(this.modelList, this.index);
}

class ShowResult extends DktEvent {}

class LoadMenuEvent extends DktEvent {}

class LoadCategoryEvent extends DktEvent {
  final String category;

  LoadCategoryEvent(this.category);
}

class RefreshEvent extends DktEvent {}

class StartPractiseEvent extends DktEvent {
  final String category;
  final int index;

  StartPractiseEvent(this.category, this.index);
}

//bloc
class DktBloc extends Bloc<DktEvent, DrivingState> {
  DktBloc(super.initialState) {
    final drivingRepo = DktRepoImplement();
    List<DktModel> masterModelList = [];
    List<CategoryModel> categroyModelList = [];
    List<DktModel> questionModelList = [];
    String previousCategory = '';
//
    on<FetchDktDataEvent>((event, emit) async {
      emit(DrivingState().copyWith(loadingvalue: true));
      List<DktModel> fetchModelData = await drivingRepo.getQuestions();
      List<CategoryModel> fetchCategory = await drivingRepo.getCategory();
      categroyModelList = fetchCategory;
      masterModelList = fetchModelData;
      Timer(
        const Duration(seconds: 2),
            () {},
      );
      emit(
        DrivingState().copyWith(
          loadingvalue: false,
          menu: menuList,
        ),
      );
    });
    //
    on<LoadMenuEvent>((event, emit) {
      emit(DrivingState().copyWith(menu: menuList));
    });

    on<LoadCategoryEvent>((event, emit) async {
      if (previousCategory == event.category.toLowerCase()) {
        emit(DrivingState().copyWith(modelList: questionModelList));
      } else {
        if (event.category.toLowerCase() == 'all') {
          previousCategory = event.category.toLowerCase();
          emit(
            DrivingState().copyWith(
              modelList: masterModelList,
              loadingvalue: false,
              menu: menuList,
            ),
          );
        } else {
          previousCategory = event.category.toLowerCase();
          questionModelList = masterModelList
              .where((element) =>
          element.category.toLowerCase() ==
              event.category.toLowerCase())
              .toList();
          emit(DrivingState().copyWith(
            modelList: masterModelList,
            loadingvalue: false,
          ));
        }
      }
    });
    on<RefreshEvent>((event, emit) async {
      // List<CategoryModel> fetchCategory = await drivingRepo.getCategory();
      emit(DrivingState().copyWith(menu: menuList));
    });
    on<StartPractiseEvent>((event, emit) async {
      emit(DrivingState().copyWith(loadingvalue: true));

      if (event.category != previousCategory) {
        previousCategory = event.category.toLowerCase();
        questionModelList = masterModelList
            .where((element) =>
        element.category.toLowerCase() == event.category.toLowerCase())
            .toList();
      }
      emit(DrivingState().copyWith(
          model: questionModelList[event.index],
          loadingvalue: false,
          index: 0
      ));
    });
  }
}
