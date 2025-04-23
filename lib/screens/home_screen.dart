import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Для использования SVG иконок
import 'package:habit_tracker/Theme/colors.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Пример данных привычек
  List<Habit> habits = [];

  final List<String> weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

  late Box<Habit> habitBox;

  @override
  void initState() {
    super.initState();
    loadHabits(); // Загружаем привычки при старте
  }

  Future<void> loadHabits() async {
    habitBox = Hive.box<Habit>('habits'); // открываем бокс
    setState(() {
      habits = habitBox.values.toList(); // получаем все привычки
    });
  }

  Future<void> saveHabit(Habit habit) async {
    await habitBox.add(habit); // сохраняем новую привычку
    setState(() {
      habits.add(habit); // добавляем в локальный список для обновления UI
    });
  }



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
                    onTap: () async {
                      final newHabit = await Navigator.pushNamed(context, '/create');
                      if (newHabit != null && newHabit is Habit) {
                        setState(() {
                          habits.add(newHabit);
                        });
                        habitBox.add(newHabit);
                      }
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
                          'assets/icons/plus_icon.svg',
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

            // Список привычек или сообщение
            Expanded(
              child: habits.isEmpty
                  ? Center(
                child: Text(
                  'У вас пока нет созданных привычек',
                  style: TextStyle(fontSize: 18, color: AppColors.primaryText),
                ),
              )
                  : ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0), // Отступ между карточками
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: habit.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Название привычки
                            Padding(
                              padding: const EdgeInsets.only(left: 9.0, bottom: 8.0),
                              child: Text(
                                habit.title,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ),
                            // Кружки для дней
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(7, (dayIndex) {
                                bool isCompleted = habit.completionStatus[dayIndex];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        habit.completionStatus[dayIndex] = !isCompleted;
                                      });
                                      await habit.save(); // сохраняем изменения в Hive
                                    },

                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: isCompleted
                                          ? Color(0xFF393B34)
                                          : Colors.transparent,
                                      child: isCompleted
                                          ? SizedBox.shrink()
                                          : Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primaryText,
                                            width: 2,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

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