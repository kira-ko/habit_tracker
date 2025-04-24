import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int colorValue;

  @HiveField(4)
  List<bool> completionStatus;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.colorValue,
    required this.completionStatus,
  });

  Color get color => Color(colorValue);

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? colorValue,
    List<bool>? completionStatus,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      completionStatus: completionStatus ?? this.completionStatus,
    );
  }
}
