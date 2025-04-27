// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/controller/course.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';
import 'package:get/get.dart';
import '/common/course_data.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  int get _curChapter => CourseController.curChapter.value;
  List get _lessons => CourseInfo['chapter_${_curChapter+1}'];
  int get _readLesson => CourseController.readLesson.value;
  List get _topics => _lessons[_readLesson]['topic'];
  List get _favorites => CourseController.favorites.value == '' ? [] : CourseController.favorites.value.split(',');
  List get _readedList => CourseController.readedList.value == '' ? [] : CourseController.readedList.value.split(',');

  @override
  void initState() {
    super.initState();
    CourseController.init();
  }

  int lessonComplete(index) {
    int total = 0;
    int readed = 0;
    List topics = _lessons[index]['topic'];
    for (int topicIndex = 0; topicIndex < topics.length; topicIndex++) {
      Map topicItem = topics[topicIndex];
      int sectionLength = topicItem['section'].length;
      total += sectionLength;
      for (int sectionIndex = 0; sectionIndex < sectionLength; sectionIndex++) {
        if (_readedList.contains('${_curChapter}_${index}_${topicIndex}_$sectionIndex')) {
          readed += 1;
        }
      }
    }
    return (readed / total * 100).toInt();
  }
  int topicComplete(item) {
    List list = item.split('_');
    List topics = _lessons[int.parse(list[1])]['topic'];
    List sections = topics[int.parse(list[2])]['section'];
    int readed = 0;
    for (int sectionIndex = 0; sectionIndex < sections.length; sectionIndex++) {
      if (_readedList.contains('${_curChapter}_${list[1]}_${list[2]}_$sectionIndex')) {
        readed += 1;
      }
    }
    return (readed / sections.length * 100).toInt();
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
                    Obx(() => _favorites.isEmpty ? Container() : Favorites()),
                    CurChapter(),
                    SizedBox(height: 16),
                    ChapterList()
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
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Favorites', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
              // Icon(Icons.arrow_forward_ios_rounded, size: 18)
            ],
          ),
          SizedBox(height: 8),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(_favorites.length, (index) => FavoritesItem(index)),
                  ),
                )
              );
            }
          )
        ],
      ),
    );
  }
  Widget FavoritesItem(index) {
    List themes = ['green', 'cyan', 'blue', 'purple'];
    return Container(
      width: 177,
      height: 184,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bg/square_${themes[int.parse(_favorites[index].split('_')[2])%4]}.png'))
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                CourseController.cancleFavorite(_favorites[index]);
              },
              child: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: Image.asset('assets/icons/star_ac.png', width: 24),
              ),
            ),
            GestureDetector(
              onTap: () {
                List list = _favorites[index].split('_');
                int lessonIndex = int.parse(list[1]);
                int topicIndex = int.parse(list[2]);
                CourseController.onReadLesson(lessonIndex);
                CourseController.onReadTopic(topicIndex);
                Get.toNamed('/lesson_detail');
              },
              child: Image.asset('assets/icons/arrow_north_east.png', width: 32),
            )
          ]
        ),
        SizedBox(height: 12),
        Text(_topics[int.parse(_favorites[index].split('_')[2])]['title'], style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700, height: 1.2)),
        Spacer(),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(children: [
            Obx(() => Container(
              width: 145 * topicComplete(_favorites[index]) / 100,
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFF282B32),
                borderRadius: BorderRadius.circular(8)
              ),
            ))
          ]),
        )
      ]),
    );
  }

  Widget CurChapter() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Current chapter', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
              GestureDetector(
                onTap: () => Get.toNamed('/chapter'),
                child: Text('More', style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.w500)),
              )
            ],
          ),
          SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/chapter'),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D4ED8),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text('Chapter ${_curChapter + 1}:', style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w500))),
                      SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Obx(() => Text(CourseController.chapters[_curChapter], style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700))),
                      )
                    ]
                  ),
                )
              ),
              Positioned(right: -4, child: Image.asset('assets/icons/chapter_1.png', width: 102))
            ],
          )
        ]
      )
    );
  }

  Widget ChapterList() {
    return Obx(() => Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(_lessons.length, (index) => ChapterItem(index))
    ));
  }
  Widget ChapterItem(index) {
    int complete = lessonComplete(index);
    return GestureDetector(
      onTap: () {
        CourseController.onReadLesson(index);
        Get.toNamed('/lesson');
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        height: 106,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(_lessons[index]['title'], style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700, height: 1.1))),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text('${_lessons[index]['topic'].length} topic', style: TextStyle(color: Color(0xFF494D55), fontSize: 12, fontWeight: FontWeight.w500))),
                Text('$complete% complete', style: TextStyle(color: Color(0xFF494D55), fontSize: 11, fontWeight: FontWeight.w400)),
              ]
            ),
            SizedBox(height: 2),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 112) / 2 * complete / 100,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF282B32),
                    borderRadius: BorderRadius.circular(8)
                  ),
                )
              ]),
            )
          ]
        ),
      ),
    );
  }
}