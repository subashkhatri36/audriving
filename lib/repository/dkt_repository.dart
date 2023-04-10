import 'dart:io';

import 'package:driveaustralia/bloc/model/cateory_model.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

String path = 'assets/dktdata.json';

abstract class DrivingRepository {
  Future<List<DktModel>> getQuestions();
  Future<List<CategoryModel>> getCategory();
  Future<bool> storeQuestions(List<DktModel> models);
}

class DktRepoImplement extends DrivingRepository {
  @override
  Future<List<DktModel>> getQuestions() async {
    try {
      List<DktModel> model = [];
      final String response = await rootBundle.loadString(path);
      final data = await json.decode(response);

      for (int i = 0; i < data.length; i++) {
        List<Option> options = [];
        String question = data[i]['question'];

        for (int o = 0; o < (data[i]['options']).length; o++) {
          options.add(
            Option(
              sno: data[i]['options'][o]['sno'],
              option: data[i]['options'][o]['option'],
            ),
          );
        }
        String img=data[i]['image'];
        model.add(
          DktModel(
            question: question,
            image:img.isEmpty?'': 'assets/questions/$img',
            options: options,
            correct: data[i]['correct'],
            category: data[i]['category'],
          ),
        );
      }

      return model;
    } catch (error) {
      print(error);
      return [];
    }
  }

  @override
  Future<bool> storeQuestions(List<DktModel> models) async {
    try {
      File file = File(path);
      file.writeAsStringSync(json.encode(models));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<CategoryModel>> getCategory() async{
    try {
      List<CategoryModel> model = [];
      final String response = await rootBundle.loadString('assets/category.json');
      final data = await json.decode(response);

      for (int i = 0; i < data.length; i++) {
        model.add(CategoryModel.fromMap(data[i]));

        }

      return model;

    } catch (error) {
      print(error);
      return [];
    }
  }
}
