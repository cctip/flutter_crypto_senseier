// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/question_data.dart';
import 'package:flutter_crypto_senseier/controller/user.dart';

class BattleDetail extends StatefulWidget {
  const BattleDetail({super.key});

  @override
  State<BattleDetail> createState() => BattleDetailState();
}

class BattleDetailState extends State<BattleDetail> {
  Timer? _timer;
  int _remainingTime = 10;
  int _chooseAnswer = -1;
  String _title = '';
  List _options = [];
  int _opponentAnswer = -1;
  int _answerIndex = -1;

  @override
  void initState() {
    super.initState();
    initQuestion();
  }
  @override
  void dispose() {
    super.dispose();
  }
  
  void initQuestion() {
    int quesIndex = Random().nextInt(Questions.length);
    setState(() {
      _title = Questions[quesIndex]['title'];
      _options = Questions[quesIndex]['options'];
      _answerIndex = Questions[quesIndex]['q_type'];
    });
    _startTimer();
  }
  void _startTimer() {
    int opponentSecond = Random().nextInt(6) + 2; // 对手选择的秒数
    int opponentAnswer = Random().nextInt(_options.length); // 对手选择的答案

    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          if (_remainingTime == opponentSecond) {
            _opponentAnswer = opponentAnswer;
          }
        } else {
          if (_answerIndex == _chooseAnswer) {
            _showSuccess();
          } else {
            _showFailed();
          }
          _timer?.cancel();
          _timer = null;
        }
      });
    });
  }
  void _showSuccess() {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false; // 返回 true 允许关闭，false 阻止关闭
        },
        child: Material(
          color: Colors.black26,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 86,
                child: Image.asset('assets/images/bg/well_done.png', width: MediaQuery.of(context).size.width)
              ),
              Positioned(
                top: 358,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: 272,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('You beat your opponent', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/xp.png', width: 32),
                            SizedBox(width: 8),
                            Text('+100', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w700))
                          ]
                        ),
                      ),
                      SizedBox(
                        width: 275,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF4C1AE2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          onPressed: () {
                            UserController.onBattleSuccess();
                            Navigator.of(context).popUntil(ModalRoute.withName('/'));
                          },
                          child: Text('Claim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                        ),
                      )
                    ]
                  ),
                )
              )
            ],
          )
        )
      )
    );
  }
  void _showFailed() {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false; // 返回 true 允许关闭，false 阻止关闭
        },
        child: Material(
          color: Colors.black26,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 86,
                child: Image.asset('assets/images/bg/come_on.png', width: MediaQuery.of(context).size.width)
              ),
              Positioned(
                top: 458,
                child: SizedBox(
                  width: 275,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF4C1AE2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                    child: Text('Back', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                  ),
                )
              )
            ],
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bg/battle_detail_bg.png'), fit: BoxFit.fill)
      ),
      child: Column(children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.close_rounded),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text('Knowledge battle', style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        ),
        Expanded(child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Obx(() => Image.asset('assets/images/avator/${UserController.avator_opponent}.png', width: 64)),
                      Text('Opponent', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
                    ]),
                    Image.asset('assets/icons/VS.png', width: 46, height: 38),
                    Column(children: [
                      Image.asset('assets/images/avator/avator_4.png', width: 64),
                      Text('You', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
                    ]),
                  ]
                ),
              ),
              SizedBox(height: 24),
              AnswerArea()
            ],
          ),
        ))
      ]),
    ));
  }

  Widget AnswerArea() {
    return Expanded(child: Column(
      children: [
        Text(_title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
        SizedBox(height: 24),
        Expanded(child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
          ),
          child: Column(children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(29, 78, 216, 0.15),
                border: Border.all(color: Color(0xFF1D4ED8), width: 2),
                borderRadius: BorderRadius.circular(48)
              ),
              child: Text('${_remainingTime}s', style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 16, fontWeight: FontWeight.w700),),
            ),
            SizedBox(height: 16),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_options.length, (index) => AnswerBtn(index)),
            )),
          ]),
        )),
        SizedBox(height: 32)
      ],
    ));
  }
  Widget AnswerBtn(index) {
    return GestureDetector(
      onTap: () {
        if (_chooseAnswer == -1) {
          setState(() => _chooseAnswer = index);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _chooseAnswer == index ? [Color(0xFF1D4ED8),Color(0xFF4C1AE2)] :
                      _opponentAnswer == index ? [Color.fromRGBO(76, 26, 226, 0.25), Color.fromRGBO(76, 26, 226, 0.25)] : [Color(0xFFF1F5F9), Color(0xFFF1F5F9)],
                stops: [0, 1], // 调整渐变范围
              ),
              border: _opponentAnswer == index ? Border.all(color: Color(0xFF4C1AE2), width: 2) : Border(),
              borderRadius: BorderRadius.circular(24)
            ),
            child: Text(
              _options[index],
              style: TextStyle(
                color: _chooseAnswer == index ? Colors.white : _opponentAnswer == index ? Color(0xFF4C1AE2) : Color(0xFF282B32),
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _opponentAnswer == index ? Positioned(
            top: -16,
            right: _opponentAnswer == _chooseAnswer ? 24 : 0,
            child: Obx(() => Container(
              width: 32,
              height: 32,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32)
              ),
              child: Image.asset('assets/images/avator/${UserController.avator_opponent}.png'),
            ))
          ) : Container(),
          _chooseAnswer == index ? Positioned(
            top: -16,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32)
              ),
              child: Image.asset('assets/images/avator/avator_4.png'),
            )
          ) : Container(),
        ],
      ),
    );
  }
}