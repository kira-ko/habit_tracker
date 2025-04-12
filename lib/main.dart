import 'package:flutter/material.dart';
import 'screens/create_habit_screen.dart'; // Импортируем экран для создания привычки
import 'screens/home_screen.dart'; // Импортируем главный экран

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // начальная страница
      routes: {
        '/create': (context) => CreateHabitScreen(), // добавляем сюда переход
      },
    );
  }
}









