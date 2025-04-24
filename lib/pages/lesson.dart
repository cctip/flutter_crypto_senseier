// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/course.dart';
import '/common/course_data.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => LessonPageState();
}
class LessonPageState extends State<LessonPage> {
  int get _curChapter => CourseController.curChapter.value;
  List get _lessons => CourseInfo['chapter_${_curChapter+1}'];
  int get _readLesson => CourseController.readLesson.value;
  List get _topics => _lessons[_readLesson]['topic'];
  List get _favorites => CourseController.favorites.value.split(',');
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      color: Color(0xFFF1F5F9),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Color(0xFFF1F5F9),
            iconTheme: IconThemeData(color: Color(0xFF15171C)),
            centerTitle: true,
            title: Text('Lesson', style: TextStyle(
              color: Color(0xFF15171C),
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          Expanded(child: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LESSON ${_readLesson+1}', style: TextStyle(color: Color(0xFFA2A6AF), fontWeight: FontWeight.w700)),
                  SizedBox(height: 10),
                  Text('${_lessons[_readLesson]['title']}', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 124,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(children: [
                          Container(
                            width: 0,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(0xFF282B32),
                              borderRadius: BorderRadius.circular(8)
                            ),
                          )
                        ]),
                      ),
                      Text('0% complete', style: TextStyle(color: Color(0xFF494D55), fontSize: 11))
                    ],
                  ),
                  SizedBox(height: 24),
                  LessionList()
                ]
              ),
            ))
          ]))
        ],
      ),
    ));
  }

  Widget LessionList() {
    List images = [
      'rectangle_green',
      'rectangle_cyan',
      'rectangle_blue',
      'rectangle_purple',
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(_topics.length, (index) => Container(
        height: 144,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg/${images[index%4]}.png'))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    CourseController.setFavorite(index);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: Obx(() => Image.asset('assets/icons/${_favorites.contains('${_curChapter}_${_readLesson}_$index') ? 'star_ac' : 'star'}.png', width: 24)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CourseController.onReadTopic(index);
                    Get.toNamed('/lesson_detail');
                  },
                  child: Image.asset('assets/icons/arrow_north_east.png', width: 32),
                )
              ]
            ),
            SizedBox(height: 24),
            Text(_topics[index]['title'], style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700, height: 1.2)),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(children: [
                Container(
                  width: 0,
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
      ))
    );
  }
}