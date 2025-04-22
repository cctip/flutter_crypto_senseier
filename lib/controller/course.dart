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
  static final curChapter = RxInt(0); // 当前章节
  static final deepChapter = RxInt(3); // 已完成到章节
}