// ignore_for_file: non_constant_identifier_names

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
    return Container(
      color: Color(0xFFF1F5F9),
      child: Column(
        children: [
          HeaderBox(),
          Expanded(child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 58 + 16),
                child: Column(
                  children: [
                    Favorites(),
                    CurChapter(),
                    
                  ],
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget HeaderBox() {
    return Container(
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
          UserBox(theme: 'dark'),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  Container(
                    width: 100,
                    height: 36,
                    alignment: Alignment.center,
                    child: Text('Miner', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  Positioned(bottom: 0, child: Container(width: 100, height: 2, color: Colors.white))
                ]),
                Stack(children: [
                  Container(
                    width: 100,
                    height: 36,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Trader', style: TextStyle(color: Color(0xFFA2A6AF), fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(width: 2),
                        Image.asset('assets/icons/lock.png', width: 16)
                      ]
                    ),
                  ),
                  // Positioned(bottom: 0, child: Container(width: 100, height: 2, color: Colors.white))
                ]),
                Stack(children: [
                  Container(
                    width: 100,
                    height: 36,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Oracle', style: TextStyle(color: Color(0xFFA2A6AF), fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(width: 2),
                        Image.asset('assets/icons/lock.png', width: 16)
                      ]
                    ),
                  ),
                  // Positioned(bottom: 0, child: Container(width: 100, height: 2, color: Colors.white))
                ]),
              ],
            ),
          )
          
        ],
      ),
    );
  }

  Widget Favorites() {
    return Container();
  }

  Widget CurChapter() {
    return Container();
  }

  Widget Chapter_1() {
    return Container();
  }

  Widget Chapter_2() {
    return Container();
  }

  Widget Chapter_3() {
    return Container();
  }

  Widget Chapter_4() {
    return Container();
  }

  Widget Chapter_5() {
    return Container();
  }

  Widget Chapter_6() {
    return Container();
  }

  Widget Chapter_7() {
    return Container();
  }
}