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
}
