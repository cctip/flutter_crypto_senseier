import '/common/share_pref.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  static final List<String> chapters = [
    'What Is Cryptocurrency?',
    'Basics of Bitcoin',
    'The History and Evolution of Cryptocurrency',
    'Types of Cryptocurrency Wallets and How to Create One',
    'How to Buy and Sell Cryptocurrency',
    'Understanding Basic Security Measures to Avoid Scams and Phishing Attacks',
    'Basic Chart Analysis in the Cryptocurrency Market',
    'Explaining Common Cryptocurrency Terminology and Abbreviations',
  ];
  
  static final readHistory = RxMap({
    'Introduction to Digital Currency': [0, 0, 0, 0],
    'How Cryptocurrencies Work': [0, 0, 0, 0],
  }); // 阅读历史记录 章节>课程>主题>文章 chapter>lesson>topic>section
  static final favorites = RxString('');

  static final curChapter = RxInt(0); // 当前章节
  static final deepChapter = RxInt(0); // 已完成到章节
  static final readLesson = RxInt(0); // 当前阅读课程
  static final readTopic = RxInt(0); // 当前阅读主题
  static final readSection = RxInt(0); // 当前阅读文章

  static init() {
    favorites.value = SharePref.getString('favorites') ?? '';
    curChapter.value = SharePref.getInt('curChapter') ?? 0;
    deepChapter.value = SharePref.getInt('deepChapter') ?? 0;
  }

  /**
   * 第一章 第一课 主题一
   */
  static String listToString(List<String> list) {
    String result = '';
    for (var str in list) {
      result = result == '' ? str : '$result,$str';
    }
    return result.toString();
  }

  // 收藏
  static setFavorite(index) {
    List<String> list = favorites.value.split(',');
    String itemStr = '${curChapter}_${readTopic}_$index';
    if (list.contains(itemStr)) {
      list.remove(itemStr);
    } else {
      list.add(itemStr);
    }
    favorites.value = listToString(list);
    SharePref.setString('favorites', favorites.value);
  }
  // 取消收藏
  static cancleFavorite(itemStr) {
    List<String> list = favorites.value.split(',');
    list.remove(itemStr);
    favorites.value = listToString(list);
    SharePref.setString('favorites', favorites.value);
  }

  static onChangeChapter(index) {
    curChapter.value = index;
    SharePref.setInt('curChapter', curChapter.value);
    onReadLesson(0);
  }
  static onReadLesson(index) {
    readLesson.value = index;
    readTopic.value = 0;
    readSection.value = 0;
  }
  static onReadTopic(index) {
    readTopic.value = index;
  }
  static onReadSection(index) {
    readSection.value = index;
  }
}