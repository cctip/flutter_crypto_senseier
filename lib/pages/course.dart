import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top + 104,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1D4ED8),
                Color(0xFF4C1AE2),
              ],
              stops: [0, 1], // 调整渐变范围
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
          ),
          child: Column(
            children: [
              UserBox(theme: 'dark')
            ],
          ),
        ),
        Expanded(child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(),
          )
        ]))
      ],
    );
  }
}