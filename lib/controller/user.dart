import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final avator = 'assets/images/avator.png'.obs;
  static final level = RxInt(1);
  static final xp = RxInt(0);
  static final xpAll = RxInt(0);

  // 初始化
  static init() {
    avator.value = SharePref.getString('avator') ?? 'assets/images/avator.png';
    level.value = SharePref.getInt('level') ?? 1;
    xp.value = SharePref.getInt('xp') ?? 0;
    xpAll.value = SharePref.getInt('xpAll') ?? 0;
  }

  // 设置头像
  static setAvator(index) {
    SharePref.setString('avator', avator.value);
  }

  static increaseXP(int value) {
    xpAll.value += value;
    if (xp.value + value >= level.value * 1000) {
      xp.value -= level.value * 1000;
      level.value++;
      SharePref.setInt('level', level.value);
    } else {
      xp.value += value;
    }
    SharePref.setInt('xp', xp.value);
    SharePref.setInt('xpAll', xpAll.value);
  }
}