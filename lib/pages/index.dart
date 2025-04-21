import 'package:flutter/material.dart';
import './home.dart';
import './course.dart';
import './battle.dart';
import './ranking.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int currentIndex = 1;

  /// Tab 改变
  void onTabChanged(int index) {
    setState(() {
      if (currentIndex != index) {
        currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              HomePage(),
              CoursePage(),
              BattlePage(),
              RankingPage()
            ],
          ),
        ],
      ),
    );
  }
}
