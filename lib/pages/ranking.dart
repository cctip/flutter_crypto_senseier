// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/common/eventbus.dart';
import 'package:flutter_crypto_senseier/controller/ranking.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
  Map get _rankingMap => RankingController.rankingMap;
  late final List _nameList = [];

  @override
  void initState() {
    super.initState();
    bus.on('calcRank', (_) => calcRank());
    RankingController.init();
  }
  
  // 计算排名
  void calcRank() {
    for (String name in _rankingMap.keys) {
      _nameList.add({
        'name': name,
        'value': _rankingMap[name]['xp']
      });
    }
    _nameList.sort((a, b) => b['value'].compareTo(a['value']));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Colors.white,
          child: UserBox(theme: 'light')
        ),
        Expanded(child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top - 56 + (_nameList.isEmpty ? 0 : 120),
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
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: -140, child: Opacity(opacity: 0.2, child: Image.asset('assets/images/bg/rank_mask.png', width: 526, fit: BoxFit.cover))),
                  Rank_1(),
                  Rank_2(),
                  Rank_3(),
                  Positioned(top: 232, child: Image.asset('assets/images/bg/rank_bg.png', width: 302, fit: BoxFit.cover)),
                  Positioned(top: 325, child: Container(
                    width: 370,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: _nameList.length <= 3 ? EmptyBox() : RankingBox(),
                  )),
                  Column(
                    children: [
                      SizedBox(height: 24),
                      Image.asset('assets/images/bg/rank_title.png', width: MediaQuery.of(context).size.width, fit: BoxFit.cover)
                    ],
                  ),
                ],
              )
            )
          )
        ]))
      ],
    );
  }

  Widget Rank_1() {
    return Positioned(top: 158, child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64,
          height: 64,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: Colors.white
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: Color(0xFFe0e0e0)
            ),
            child: _nameList.isEmpty
              ? Icon(Icons.question_mark_rounded, color: Colors.black38, size: 32)
              : Image.asset('assets/images/avator/${_rankingMap[_nameList[0]['name']]['avator']}.png'),
          ),
        ),
        Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_1.png', width: 24)),
        _nameList.isEmpty ? Container() : Positioned(
          bottom: -8,
          child: Container(
            height: 24,
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Row(children: [
              Image.asset('assets/icons/xp.png', width: 24),
              SizedBox(width: 4),
              Text('${_rankingMap[_nameList[0]['name']]['xp']}', style: TextStyle(color: Color(0xFF15171C), fontWeight: FontWeight.w700))
            ]),
          )
        )
      ],
    ));
  }
  Widget Rank_2() {
    return Positioned(top: 190, left: 80, child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: Colors.white
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: Color(0xFFe0e0e0)
            ),
            child: _nameList.length <= 1
              ? Icon(Icons.question_mark_rounded, color: Colors.black38)
              : Image.asset('assets/images/avator/${_rankingMap[_nameList[1]['name']]['avator']}.png'),
          ),
        ),
        Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_2.png', width: 16)),
        _nameList.length <= 1 ? Container() : Positioned(
          bottom: -6,
          child: Container(
            height: 16,
            padding: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              children: [
              Image.asset('assets/icons/xp.png', width: 16),
              SizedBox(width: 4),
              Text('${_rankingMap[_nameList[1]['name']]['xp']}', style: TextStyle(color: Color(0xFF15171C), fontSize: 12, fontWeight: FontWeight.w700))
            ]),
          )
        )
      ],
    ));
  }
  Widget Rank_3() {
    return Positioned(top: 190, right: 80, child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: Colors.white
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: Color(0xFFe0e0e0)
            ),
            child: _nameList.length <= 2
              ? Icon(Icons.question_mark_rounded, color: Colors.black38)
              : Image.asset('assets/images/avator/${_rankingMap[_nameList[2]['name']]['avator']}.png'),
          ),
        ),
        Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_3.png', width: 16)),
        _nameList.length <= 2 ? Container() : Positioned(
          bottom: -6,
          child: Container(
            height: 16,
            padding: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              children: [
              Image.asset('assets/icons/xp.png', width: 16),
              SizedBox(width: 4),
              Text('${_rankingMap[_nameList[2]['name']]['xp']}', style: TextStyle(color: Color(0xFF15171C), fontSize: 12, fontWeight: FontWeight.w700))
            ]),
          )
        )
      ],
    ));
  }

  Widget EmptyBox() {
    return Column(
      children: [
        SizedBox(height: 32),
        _nameList.isEmpty ? Text('The leaderboard is empty... for now.', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)) : Container(),
        Text('Make your move!', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 30),
        SizedBox(
          width: 338,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF15171C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            onPressed: () {
              bus.emit('tabChange', 1);
            },
            child: Text('Learning', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
          ),
        ),
      ],
    );
  }
  Widget RankingBox() {
    return SizedBox(
      child: Column(children: List.generate(_nameList.length, (index) => index < 3 ? Container() : Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text('${index+1}.', style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900)),
          SizedBox(width: index >= 9 ? 10 : 24),
          Image.asset('assets/images/avator/${_rankingMap[_nameList[index]['name']]['avator']}.png', width: 40),
          SizedBox(width: 12),
          Text(_nameList[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Spacer(),
          Image.asset('assets/icons/xp.png', width: 24),
          SizedBox(width: 4),
          Text('${_rankingMap[_nameList[index]['name']]['xp']}', style: TextStyle(fontWeight: FontWeight.w700))
        ],),
      ))),
    );
  }
}