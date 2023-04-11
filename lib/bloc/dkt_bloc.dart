// ignore_for_file: public_member_api_docs, sort_constructors_first

//state

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
  final List<DktModel>? models;
  final List<DktModel>? categoryModelList;
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
    this.categoryModelList,
  });

  DrivingState copyWith({
    List<DktModel>? models,
    List<DktModel>? categoryModelList,
    DktModel? model,
    List<CategoryModel>? categorys,
    bool? isanimation,
    bool? loadingvalue,
    bool? answerSelect,
    List<MenuList>? menu,
  }) {
    return DrivingState(
      models: models ?? this.models,
      categoryModelList: categoryModelList ?? this.categoryModelList,
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

class LoadCategoryEvent extends DktEvent {
  final String category;

  LoadCategoryEvent(this.category);
}

class RefreshEvent extends DktEvent {}

//bloc
class DktBloc extends Bloc<DktEvent, DrivingState> {
  DktBloc(super.initialState) {
    final drivingRepo = DktRepoImplement();

    on<FetchDktDataEvent>((event, emit) async {
      List<DktModel> fetchModelData = await drivingRepo.getQuestions();
      emit(
        DrivingState().copyWith(
          models: fetchModelData,
          loadingvalue: false,
          menu: menuList,
        ),
      );
    });
    on<LoadMenuEvent>((event, emit) {
      emit(DrivingState().copyWith(menu: menuList));
    });

    on<LoadCategoryEvent>((event, emit) async {
      List<DktModel> categoryQuestionList = [];
      int modelValue = state.models?.length ?? 0;
      if (modelValue == 0) {
        List<DktModel> fetchModelData = await drivingRepo.getQuestions();
        emit(
          DrivingState().copyWith(
            models: fetchModelData,
            loadingvalue: false,
            menu: menuList,
          ),
        );
      }
      if (state.models != null && event.category.toLowerCase() != "all") {
        categoryQuestionList = state.models!
            .where((element) =>
                element.category.toLowerCase() == event.category.toLowerCase())
            .toList();
      } else {
        categoryQuestionList = state.models ?? [];
      }

      emit(DrivingState().copyWith(categoryModelList: categoryQuestionList));
    });
    on<RefreshEvent>((event, emit) async {
      // List<CategoryModel> fetchCategory = await drivingRepo.getCategory();
      emit(DrivingState().copyWith(menu: menuList));
    });
  }
}
