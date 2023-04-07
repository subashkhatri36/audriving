// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String category;
  final int totalQuestions;
  final int wrongQuestions;
  CategoryModel({
    required this.category,
    required this.totalQuestions,
    required this.wrongQuestions,
  });

  CategoryModel copyWith({
    String? category,
    int? totalQuestions,
    int? wrongQuestions,
  }) {
    return CategoryModel(
      category: category ?? this.category,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      wrongQuestions: wrongQuestions ?? this.wrongQuestions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'totalQuestions': totalQuestions,
      'wrongQuestions': wrongQuestions,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category: map['category'] as String,
      totalQuestions: map['totalQuestions'] as int,
      wrongQuestions: map['wrongQuestions'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(category: $category, totalQuestions: $totalQuestions, wrongQuestions: $wrongQuestions)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.totalQuestions == totalQuestions &&
        other.wrongQuestions == wrongQuestions;
  }

  @override
  int get hashCode =>
      category.hashCode ^ totalQuestions.hashCode ^ wrongQuestions.hashCode;
}
