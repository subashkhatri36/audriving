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

final category = [
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
  final bool isPractiseOrTest;
  final bool isTest;

  DrivingState({
    this.modelList,
    this.model,
    this.categorys,
    this.loadingvalue = false,
    this.answerSelect = false,
    this.selectedIndex = -1,
    this.menu,
    this.index = 0,
    this.isPractiseOrTest = false,
    this.isTest = false,
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
    bool? isPractiseOrTest,
    bool? isTest,
  }) {
    return DrivingState(
      modelList: modelList ?? this.modelList,
      model: model ?? this.model,
      categorys: categorys ?? this.categorys,
      loadingvalue: loadingvalue ?? this.loadingvalue,
      answerSelect: answerSelect ?? this.answerSelect,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      menu: menu ?? this.menu,
      index: index ?? this.index,
      isPractiseOrTest: isPractiseOrTest ?? this.isPractiseOrTest,
      isTest: isTest ?? this.isTest,
    );
  }
}

//Event
abstract class DktEvent {}

class FetchDktDataEvent extends DktEvent {}

class WriteDktDataEvent extends DktEvent {}

class SelectAnswerEvent extends DktEvent {
  final int selectedIndex;
  final int index;

  SelectAnswerEvent({required this.selectedIndex, required this.index});
}

class ShowRules extends DktEvent {}

class NextQuestion extends DktEvent {
  final int index;
  final bool isTest;

  NextQuestion(this.index, this.isTest);
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

class StartTestEvent extends DktEvent {
  final String category;
  final int index;

  StartTestEvent(this.category, this.index);
}

//bloc
class DktBloc extends Bloc<DktEvent, DrivingState> {
  List<DktModel> questionModelList = [];

  DktBloc(super.initialState) {
    final drivingRepo = DktRepoImplement();
    List<DktModel> masterModelList = [];
    List<CategoryModel> categroyModelList = [];

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
            modelList: questionModelList,
            loadingvalue: false,
          ));
        }
      }
    });
    on<RefreshEvent>((event, emit) async {
      // List<CategoryModel> fetchCategory = await drivingRepo.getCategory();
      emit(DrivingState().copyWith(menu: menuList));
    });

    on<SelectAnswerEvent>((event, emit) {
      DktModel old = questionModelList[event.index]
          .copyWith(selectCorrect: event.selectedIndex);

      questionModelList[event.index] = old;
      emit(DrivingState().copyWith(
        model: old,
        modelList: questionModelList,
        index: event.index,
      ));
    });

    on<StartPractiseEvent>((event, emit) async {
      emit(DrivingState().copyWith(loadingvalue: true));
      questionModelList = [];

      questionModelList = masterModelList
          .where((element) =>
      element.category.toLowerCase() == event.category.toLowerCase() ||
          event.category.toLowerCase() == 'all')
          .toList();

      emit(DrivingState().copyWith(
          model: questionModelList[event.index ?? 0],
          loadingvalue: false,
          modelList: questionModelList,
          index: event.index));
    });

    on<NextQuestion>((event, emit) {
      int lastIndex = 0;
      emit(DrivingState().copyWith(
        loadingvalue: true,
      ));

      if (event.index < questionModelList.length) {
        lastIndex = event.index;
        emit(DrivingState().copyWith(
            model: questionModelList[event.index ?? 0],
            loadingvalue: false,
            modelList: questionModelList,
            index: event.index));
      } else {
        if (event.isTest) {

        } else {
          emit(DrivingState().copyWith(
              model: questionModelList[lastIndex ?? 0],
              loadingvalue: false,
              modelList: questionModelList,
              index: -10));
        }
      }
    });

    on<StartTestEvent>((event, emit) {
      emit(DrivingState().copyWith(loadingvalue: true));
      questionModelList = [];

      List<DktModel> alcoholList = [];
      List<DktModel> carList = [];
      List<DktModel> drivingList = [];
      List<DktModel> vulnerableList = [];
      List<DktModel> seatList = [];
      List<DktModel> intersectList = [];
      for (var model in masterModelList) {
        switch (model.category) {
          case 'Alcohol and Drugs':
            alcoholList.add(model);
            break;
          case 'Car General':
            carList.add(model);
            break;
          case 'Driving General':
            drivingList.add(model);
            break;
          case 'Vulnerable Road Users':
            vulnerableList.add(model);
            break;
          case 'Seat Belts':
            seatList.add(model);
            break;
          case 'Intersections':
            intersectList.add(model);
            break;
        }
      }

      //suffel list
      alcoholList.shuffle();
      carList.shuffle();
      drivingList.shuffle();
      vulnerableList.shuffle();
      seatList.shuffle();
      intersectList.shuffle();

      int alc = 0,
          car = 0,
          dri = 0,
          vuln = 0,
          sea = 0,
          inter = 0;
      for (var category in categroyModelList) {
        switch (category.category) {
          case 'Alcohol and Drugs':
            filterModelList(category.totalQuestions, alcoholList);

            break;
          case 'Car General':
            filterModelList(category.totalQuestions, carList);
            break;
          case 'Driving General':
            filterModelList(category.totalQuestions, drivingList);
            break;
          case 'Vulnerable Road Users':
            filterModelList(category.totalQuestions, vulnerableList);
            break;
          case 'Seat Belts':
            filterModelList(category.totalQuestions, seatList);
            break;
          case 'Intersections':
            filterModelList(category.totalQuestions, intersectList);
            break;
        }
      }

      emit(DrivingState().copyWith(
          model: questionModelList[event.index ?? 0],
          loadingvalue: false,
          modelList: questionModelList,
          index: event.index));
    });
  }

  filterModelList(int totalquestions, List<DktModel> list) {
    int index = 1;
    for (var l in list) {
      if (index < totalquestions) {
        index++;
        questionModelList.add(l);
      }
    }
  }
}
