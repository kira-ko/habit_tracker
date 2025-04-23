import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/create_habit_screen.dart'; // Импортируем экран для создания привычки
import 'screens/home_screen.dart'; // Импортируем главный экран
import 'models/habit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habits');

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









