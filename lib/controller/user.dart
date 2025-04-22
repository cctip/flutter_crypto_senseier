import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final avator = 'assets/images/avator.png'.obs;
  static final level = RxInt(30);

  // 初始化
  static init() {
    avator.value = SharePref.getString('avator') ?? 'assets/images/avator.png';
    level.value = SharePref.getInt('level') ?? 1;
  }

  // 设置头像
  static setAvator(index) {
    SharePref.setString('avator', avator.value);
  }
}