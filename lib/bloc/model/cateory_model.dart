import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  final String category;
  final int totalQuestions;
  final int wrongQuestions;
  final String icon;
  CategoryModel({
    required this.category,
    required this.totalQuestions,
    required this.wrongQuestions,
    required this.icon,
  });

  CategoryModel copyWith({
    String? category,
    int? totalQuestions,
    int? wrongQuestions,
    String? icon,
  }) {
    return CategoryModel(
      category: category ?? this.category,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      wrongQuestions: wrongQuestions ?? this.wrongQuestions,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'totalQuestions': totalQuestions,
      'wrongQuestions': wrongQuestions,
      'icon': icon,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category: map['category'] as String,
      totalQuestions: map['totalQuestions'] as int,
      wrongQuestions: map['wrongQuestions'] as int,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(category: $category, totalQuestions: $totalQuestions, wrongQuestions: $wrongQuestions, icon: $icon)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.totalQuestions == totalQuestions &&
        other.wrongQuestions == wrongQuestions &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        totalQuestions.hashCode ^
        wrongQuestions.hashCode ^
        icon.hashCode;
  }
}
