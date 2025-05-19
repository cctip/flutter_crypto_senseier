// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/controller/course.dart';
import 'package:get/get.dart';
import '/common/course_data.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => LessonDetailState();
}
class LessonDetailState extends State<LessonDetail> with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _remainingTime = 10;
  late AnimationController _controller;
  late Animation<double> _animation;

  int get _curChapter => CourseController.curChapter.value;
  Map get _curLessonObj => CourseInfo['chapter_${_curChapter+1}'][CourseController.readLesson.value];
  Map get _curTopicObj => _curLessonObj['topic'][CourseController.readTopic.value];
  List get _sections => _curTopicObj['section'];
  List get _readedList => CourseController.readedList.value == '' ? [] : CourseController.readedList.value.split(',');
  int get _maxReadSection => CourseController.readSection.value;
  int _curSection = 0;
  
  @override
  void initState() {
    super.initState();
    initProgress();
    _controller = AnimationController(duration: Duration(seconds: 10), vsync: this);
    _startTimer();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initProgress() {
    setState(() => _curSection = 0);
    for(String item in _readedList) {
      if (item.contains('${_curChapter}_${CourseController.readLesson.value}_${CourseController.readTopic.value}_')) {
        if (_curSection < _sections.length - 1) {
          setState(() => _curSection++);
        }
      }
    }
    CourseController.onReadSection(_curSection);
  }
  void _startTimer() {
    _controller.forward();
    // 动画结束标记已读
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        CourseController.onReadedSection(_curSection);
      }
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _timer = null;
        }
      });
    });
  }

  void _onNext() {
    if (_curSection < _sections.length - 1) {
      if (_maxReadSection == _curSection) {
        CourseController.onReadSection(_curSection + 1);
        setState(() => _remainingTime = 10);
        _controller.reset();
        _startTimer();
      }
      setState(() => _curSection += 1);
    }
  }
  void _onFinish() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6A2BED), Color(0xFF4C1AE2)],
          stops: [0, 1], // 调整渐变范围
        ),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close_rounded),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text('Topic', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          PageHeader(),
          PageContent(),
          FooterBtn()
        ],
      ),
    ));
  }

  Widget PageHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => Text(_curTopicObj['title'], style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700), textAlign: TextAlign.center))
        ),
        SizedBox(height: 16),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Container(
              height: 24,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  Container(
                    height: 6,
                    margin: EdgeInsets.only(top: 9, left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF9268F1),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(children: [
                      Container(
                        width: (constraints.maxWidth - 18) / _sections.length * _maxReadSection,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)
                        ),
                      )
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_sections.length, (index) => GestureDetector(
                      onTap: () {
                        if (_remainingTime != 0) return;
                        if (_maxReadSection < index) return;
                        setState(() => _curSection = index);
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        child: Row(children: [Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _maxReadSection >= index ? Colors.white : Color(0xFF9268F1),
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _curSection == index ? Colors.black : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                              )
                            ]
                          ),
                        )]),
                      ),
                    ))
                  )
                ],
              ),
            ),
          );
        }),
        SizedBox(height: 24),
      ],
    );
  }

  Widget PageContent() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)
        ),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => TextTitle(_sections[_curSection]['title'])),
                Obx(() => TextContent(_sections[_curSection]['content'])),
              ]
            )
          ))
        ])
      )
    );
  }

  Widget TextTitle(text) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700, height: 2.4)),
    );
  }
  Widget TextContent(text) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(text, style: TextStyle(color: Color(0xFF494D55), fontSize: 16, fontWeight: FontWeight.w500, height: 1.3)),
    );
  }
 
  Widget FooterBtn() {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      height: 54,
      margin: EdgeInsets.only(top: 32, left: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color.fromRGBO(21, 23, 28, 0.35),
        borderRadius: BorderRadius.circular(16)
      ),
      child: _remainingTime == 0 ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF6A2BED),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: _maxReadSection == _sections.length - 1 ? _onFinish : _onNext,
          child: Text(_maxReadSection == _sections.length - 1 ? 'Finish' : 'Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
        ) : Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: (MediaQuery.of(context).size.width - 64) * _animation.value,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
              );
            },
          )),
          Positioned(child: Text('${_remainingTime}s', style: TextStyle(color: Color(0xFF6A2BED), fontSize: 18, fontWeight: FontWeight.w700)))
        ]
      ),
    );
  }
}