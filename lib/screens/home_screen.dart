import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Для использования SVG иконок
import 'package:habit_tracker/Theme/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Пример данных привычек
  final List<Habit> habits = [
    Habit(name: 'Пить воду', color: AppColors.green),
    Habit(name: 'Зарядка', color: AppColors.blue),
    Habit(name: 'Чтение', color: AppColors.pink),
  ];

  // Логика для отслеживания выполнения привычки (можно делать с помощью bool для каждого дня)
  List<List<bool>> habitCompletionStatus = [
    [false, false, false, false, false, false, false], // Статус выполнения для первой привычки
    [true, false, true, false, true, false, true], // Для второй привычки
    [false, false, false, false, false, false, false], // Для третьей привычки
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Фон экрана
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0), // Отступы по бокам
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Кнопки сверху
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 0.0, right: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Кнопка статистики (слева)
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/statistics_icon.svg',
                      width: 28, // Устанавливаем размеры иконки
                      height: 28,
                    ),
                    onPressed: () {
                      // Логика для открытия экрана статистики
                    },
                  ),
                  // Кнопка создания привычки
                  GestureDetector(
                    onTap: () {
                      // Переход на экран создания привычки
                      Navigator.pushNamed(context, '/create');
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Color(0xFF393B34), // Темный цвет для кнопки
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/plus_icon.svg', // Путь к твоей иконке
                          width: 22,
                          height: 22,
                          color: Color(0xFFFFFBF4), // Цвет иконки
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Заголовок "Мои привычки"
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Мои привычки',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
            ),

            // Дни недели с отступами по бокам
            Padding(
              padding: const EdgeInsets.only(top: 16.0), // Отступ между заголовком и днями недели
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0), // Отступы слева и справа
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Равномерное распределение
                  children: List.generate(
                    7,
                        (index) {
                      final daysOfWeek = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
                      return Text(
                        daysOfWeek[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Отображение привычек, если они есть
            Padding(
              padding: const EdgeInsets.only(top: 20.0), // Отступ между днями недели и привычками
              child: Column(
                children: habits.asMap().map((habitIndex, habit) {
                  return MapEntry(
                    habitIndex,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0), // Отступ между карточками
                      child: Container(
                        width: 380,
                        height: 120,
                        decoration: BoxDecoration(
                          color: habit.color, // Цвет карточки зависит от привычки
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Название привычки
                              Text(
                                habit.name,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              // Дни недели для отметок выполнения
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(7, (index) {
                                    bool isCompleted = habitCompletionStatus[habitIndex][index]; // Логика выполнения привычки
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            habitCompletionStatus[habitIndex][index] = !isCompleted;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: isCompleted
                                              ? Color(0xFF393B34) // Темный цвет, когда выполнено
                                              : Colors.transparent, // Прозрачный, когда не выполнено
                                          child: isCompleted
                                              ? SizedBox.shrink()
                                              : Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.primaryText, // Цвет контура
                                                width: 2, // Толщина контура
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).values.toList(),
              ),
            ),
          ],
        ),
      ),

      // Нижняя панель с иконкой домика
      bottomNavigationBar: BottomAppBar(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/homepage_icon.svg',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              // Логика перехода на главный экран
            },
          ),
        ),
      ),
    );
  }
}

// Модель привычки
class Habit {
  final String name;
  final Color color;

  Habit({required this.name, required this.color});
}
