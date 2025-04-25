// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/controller/user.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';
import 'package:get/get.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({super.key});

  @override
  State<BattlePage> createState() => BattlePageState();
}

class BattlePageState extends State<BattlePage> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  _onStartBattle() {
    Future.delayed(const Duration(milliseconds: 3800), () {
      UserController.onBattle();
      Get.back();
      Get.toNamed('/battle_detail');
    });
    List opponents = ['avator_1', 'avator_2', 'avator_3', 'avator_5', 'avator_6', 'avator_7', 'avator_8', 'avator_9', 'avator_10', 'avator_11', 'avator_12', 'avator_13', 'avator_14', 'avator_15', 'avator_16', 'avator_17', 'avator_18', 'avator_19', 'avator_20'];
    int endIndex = Random().nextInt(opponents.length);
    UserController.setOpponent(opponents[endIndex]);
    Future.delayed(const Duration(milliseconds: 20), () {
      _scrollController.animateTo(
        _scrollController.offset + 96 * (endIndex + 37) - 62,
        duration: Duration(milliseconds: 3000),
        curve: Curves.easeInOut,
      );
    });
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async { return false; },
        child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 400, child: Container(
            width: MediaQuery.of(context).size.width,
            height: 112,
            color: Color(0xFF15171C),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: opponents.length * 4,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset('assets/images/avator/${opponents[index % 19]}.png', width: 64),
                  )
                ),
                Image.asset('assets/images/bg/circle_ring.png', width: 88),
              ]
            ),
          )),
          Positioned(top: 240, child: Image.asset('assets/images/bg/battle_musk.png', width: MediaQuery.of(context).size.width)),
        ],
      ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bg/battle_bg.png'), fit: BoxFit.cover)
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.white,
            child: UserBox(theme: 'light')
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 58 - 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(top: 24, child: Image.asset('assets/images/bg/battle_title.png', width: MediaQuery.of(context).size.width, fit: BoxFit.cover)),
                Positioned(top: 130, left: 0, child: Image.asset('assets/images/bg/battle_me.png', height: 134)),
                Positioned(child: Image.asset('assets/images/bg/battle_vs.png', width: 116)),
                Positioned(bottom: 130, right: 0, child: Image.asset('assets/images/bg/battle_other.png', height: 134)),
                Positioned(bottom: 20, child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF15171C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: _onStartBattle,
                    child: Text('Free Start', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}