// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/common/utils.dart';
import 'package:get/get.dart';
import '/controller/course.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({super.key});

  @override
  State<ChapterPage> createState() => ChapterPageState();
}
class ChapterPageState extends State<ChapterPage> {
  List<String> get _chapters => CourseController.chapters;
  int get _curChapter => CourseController.curChapter.value;
  int get _deepChapter => CourseController.deepChapter.value;
  
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
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Color(0xFF15171C)),
            centerTitle: true,
            title: Text('Chapter', style: TextStyle(
              color: Color(0xFF15171C),
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          Expanded(child: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
              child: Column(children: [
                CurChapter(),
                SizedBox(height: 24),
                OtherChapters()
              ]),
            ))
          ]))
        ],
      ),
    ));
  }

  Widget CurChapter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFF6A2BED),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text('Chapter ${_curChapter+1}:', style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.w500))),
                  SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Obx(() => Text(CourseController.chapters[_curChapter], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))),
                  )
                ]
              ),
            ),
            Positioned(right: 8, child: Image.asset('assets/icons/chapter_1.png', width: 72))
          ],
        )
      ]
    );
  }

  Widget OtherChapters() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Other', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        ...List.generate(_chapters.length, (index) => _curChapter == index ? Container() : ChapterItem(index))
      ],
    ));
  }

  Widget ChapterItem(index) {
    return GestureDetector(
      onTap: () {
        if (_deepChapter > index) {
          CourseController.onChangeChapter(index);
        } else {
          Utils.toast(context, message: 'Not unlocked');
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(() => Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _deepChapter > index ? Colors.white : Color(0xFFE2E8F0),
                border: Border.all(color: _deepChapter > index ? Color(0xFF1D4ED8) : Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chapter ${index+1}:', style: TextStyle(color: Color(_deepChapter > index ? 0xFFA2A6AF : 0xFFA2A6AF), fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Text(_chapters[index], style: TextStyle(color: Color(_deepChapter > index ? 0xFF282B32 : 0xFFA2A6AF), fontSize: 18, fontWeight: FontWeight.w500)),
                  )
                ]
              ),
            )),
            Positioned(right: 8, child: Image.asset('assets/icons/chapter_${index+1}.png', width: 72))
          ],
        ),
      ),
    );
  }
}