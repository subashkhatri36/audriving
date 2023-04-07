import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Option {
  final int sno;
  final String option;
  const Option({
    required this.sno,
    required this.option,
  });

  Option copyWith({
    int? sno,
    String? option,
  }) {
    return Option(
      sno: sno ?? this.sno,
      option: option ?? this.option,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sno': sno,
      'option': option,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      sno: map['sno'] as int,
      option: map['option'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Option(sno: $sno, option: $option)';

  @override
  bool operator ==(covariant Option other) {
    if (identical(this, other)) return true;

    return other.sno == sno && other.option == option;
  }

  @override
  int get hashCode => sno.hashCode ^ option.hashCode;
}

class DktModel {
  final String question;
  final String image;
  final List<Option> options;
  final int correct;
  final String category;
  DktModel({
    required this.question,
    required this.image,
    required this.options,
    required this.correct,
    required this.category,
  });

  DktModel copyWith({
    String? question,
    String? image,
    List<Option>? options,
    int? correct,
    String? category,
  }) {
    return DktModel(
      question: question ?? this.question,
      image: image ?? this.image,
      options: options ?? this.options,
      correct: correct ?? this.correct,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'image': image,
      'options': options.map((x) => x.toMap()).toList(),
      'correct': correct,
      'category': category,
    };
  }

  factory DktModel.fromMap(Map<String, dynamic> map) {
    return DktModel(
      question: map['question'] as String,
      image: map['image'] as String,
      options: List<Option>.from(
        (map['options'] as List<int>).map<Option>(
          (x) => Option.fromMap(x as Map<String, dynamic>),
        ),
      ),
      correct: map['correct'] as int,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DktModel.fromJson(String source) =>
      DktModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DktModel(question: $question, image: $image, options: $options, correct: $correct, category: $category)';
  }

  @override
  bool operator ==(covariant DktModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        other.image == image &&
        listEquals(other.options, options) &&
        other.correct == correct &&
        other.category == category;
  }

  @override
  int get hashCode {
    return question.hashCode ^
        image.hashCode ^
        options.hashCode ^
        correct.hashCode ^
        category.hashCode;
  }
}
