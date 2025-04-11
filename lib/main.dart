import 'package:flutter/material.dart';
import 'screens/create_habit_screen.dart'; // Импортируем экран для создания привычки

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreateHabitScreen(), // Здесь запускаем экран создания привычки
    );
  }
}









