import 'package:flutter/material.dart';
import 'package:habit_tracker/Theme/colors.dart'; // Подключаем файл с цветами
import 'package:habit_tracker/models/habit.dart'; // Импортируем модель привычки

class CreateHabitScreen extends StatefulWidget {
  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  // Список привычек
  List<Habit> habits = [];

  // Контроллеры для полей ввода (для создания привычек)
  TextEditingController _habitNameController = TextEditingController();
  TextEditingController _habitDescriptionController = TextEditingController();
  Color habitColor = AppColors.green; // По умолчанию зеленый

  // Функция проверки, введено ли название привычки
  bool get isSaveEnabled => _habitNameController.text.isNotEmpty;

  // Логика для отслеживания выполнения привычек
  List<List<bool>> habitCompletionStatus = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Фон всего экрана
      body: SingleChildScrollView( // Оборачиваем все содержимое в ScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Цветная верхняя панель
            Container(
              width: double.infinity,
              height: 250,
              color: habitColor, // Цвет привычки
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Кнопка назад
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primaryText), // Стрелочка
                      onPressed: () {
                        Navigator.pop(context); // Возвращаемся на предыдущий экран
                      },
                    ),
                    // Кнопка сохранить, видимая только если введено название привычки
                    Visibility(
                      visible: isSaveEnabled,
                      child: ElevatedButton(
                        onPressed: isSaveEnabled
                            ? () {
                          // Создаем привычку
                          Habit newHabit = Habit(
                            title: _habitNameController.text,
                            description: _habitDescriptionController.text,
                            color: habitColor,
                          );

                          // Возвращаемся на предыдущий экран и передаем привычку
                          Navigator.pop(context, newHabit);
                        }
                            : null,
                        child: Text('Сохранить', style: TextStyle(color: AppColors.background)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Название привычки
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _habitNameController,
                style: TextStyle(fontSize: 32, color: AppColors.primaryText),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Название привычки',
                  hintStyle: TextStyle(color: AppColors.primaryText),
                ),
                onChanged: (text) {
                  setState(() {}); // Чтобы обновить видимость кнопки "Сохранить"
                },
              ),
            ),

            // Блок с описанием
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание',
                        style: TextStyle(fontSize: 18, color: AppColors.primaryText),
                      ),
                      TextField(
                        controller: _habitDescriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите описание',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Блок с выбором цвета
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Цвет',
                        style: TextStyle(fontSize: 18, color: AppColors.primaryText),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var color in [
                            AppColors.green,
                            AppColors.pink,
                            AppColors.blue,
                            AppColors.yellow,
                          ])
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  habitColor = color;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    key: ValueKey(color),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: habitColor == color
                                        ? Icon(
                                      Icons.check,
                                      color: AppColors.primaryText,
                                      size: 24,
                                    )
                                        : SizedBox.shrink(),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
