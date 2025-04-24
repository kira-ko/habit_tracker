import 'package:hive/hive.dart';

class HiveBoxes {
  static Box get habitsBox => Hive.box('habitsBox');
  static Box get settingsBox => Hive.box('settingsBox');
}
