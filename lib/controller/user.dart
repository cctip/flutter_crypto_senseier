import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final avator = 'avator_4'.obs;
  static final avator_opponent = 'avator_1'.obs;
  static final level = RxInt(1);
  static final xp = RxInt(0);
  static final xpAll = RxInt(0);
  static final battleCount = RxInt(0); // battle次数
  static final battleCountWin = RxInt(0); // battle胜利次数

  // 初始化
  static init() {
    avator.value = SharePref.getString('avator') ?? 'avator_4';
    level.value = SharePref.getInt('level') ?? 1;
    xp.value = SharePref.getInt('xp') ?? 0;
    xpAll.value = SharePref.getInt('xpAll') ?? 0;
    battleCount.value = SharePref.getInt('battleCount') ?? 0;
    battleCountWin.value = SharePref.getInt('battleCountWin') ?? 0;
  }

  // 设置头像
  static setAvator(index) {
    SharePref.setString('avator', avator.value);
  }
  // 设置对手头像
  static setOpponent(val) {
    avator_opponent.value = val;
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

  static onBattle() {
    battleCount.value++;
    SharePref.setInt('battleCount', battleCount.value);
  }
  static onBattleSuccess() {
    increaseXP(100);
    battleCountWin.value++;
    SharePref.setInt('battleCountWin', battleCountWin.value);
  }
}