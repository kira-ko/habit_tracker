import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'hive_boxes.dart';
import '../models/habit.dart';

class ResetService {
  static Future<void> resetIfNeeded() async {
    final settingsBox = HiveBoxes.settingsBox;
    final habitsBox = HiveBoxes.habitsBox;

    final now = DateTime.now();

    // Проверяем: сегодня понедельник?
    if (now.weekday != DateTime.monday) return;

    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    final lastReset = settingsBox.get('lastResetDate');

    // Если уже сбрасывали сегодня — ничего не делаем
    if (lastReset == todayStr) return;

    // Обнуляем прогресс у всех привычек
    for (int i = 0; i < habitsBox.length; i++) {
      final habit = habitsBox.getAt(i) as Habit;

      // Заменяем список выполненных дней на пустой (список из false)
      final updatedHabit = habit.copyWith(completionStatus: List.filled(7, false));
      habitsBox.putAt(i, updatedHabit);
    }

    // Сохраняем дату последнего сброса
    settingsBox.put('lastResetDate', todayStr);
  }
}
