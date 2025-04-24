// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/common/eventbus.dart';
import 'package:flutter_crypto_senseier/controller/sense.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SenseController.init();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => bus.emit('tabChange', 2),
                      child: Image.asset('assets/images/bg/challenge.png'),
                    ),
                    SizedBox(height: 24),
                    DailyTask(),
                    SizedBox(height: 24),
                    CommonSense(),
                  ]
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
      height: MediaQuery.of(context).padding.top + 250,
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
          Container(
            height: 194,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  HeaderMiner(),
                  SizedBox(width: 8),
                  HeaderTrader(),
                  SizedBox(width: 8),
                  HeaderOracle(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget HeaderMiner() {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 146,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF94FF22),
                  Color(0xFFC8FF24),
                ],
                stops: [0, 1], // 调整渐变范围
              ),
              borderRadius: BorderRadius.circular(16)
            ),
          ),
          Container(
            height: 106,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
            ),
            child: Column(children: [
              SizedBox(height: 14),
              Text('Miner', style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700)),
              SizedBox(height: 2),
              Text('Beginners', style: TextStyle(color: Color(0xFF494D55), fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 12),
              SizedBox(width: 72, height: 24, child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => bus.emit('tabChange', 1),
                child: Text('Learn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              ))
            ]),
          ),
          Positioned(top: -16, child: Image.asset('assets/icons/tab_miner.png', width: 56))
        ],
      ),
    );
  }
  Widget HeaderTrader() {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 146,
            decoration: BoxDecoration(
              color: Color(0xFFE2E8F0),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Color(0xFF18B8EE), Color(0xFF0FFFE3)],
              //   stops: [0, 1], // 调整渐变范围
              // ),
              borderRadius: BorderRadius.circular(16)
            ),
          ),
          Container(
            height: 106,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
            ),
            child: Column(children: [
              SizedBox(height: 14),
              Text('Trader', style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700)),
              SizedBox(height: 2),
              Text('Experienced users', style: TextStyle(color: Color(0xFF494D55), fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 12),
              SizedBox(width: 72, height: 24, child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: null,
                child: Text('Learn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              ))
            ]),
          ),
          Positioned(top: -16, child: Image.asset('assets/icons/tab_trader_disabled.png', width: 56))
        ],
      ),
    );
  }
  Widget HeaderOracle() {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 146,
            decoration: BoxDecoration(
              color: Color(0xFFE2E8F0),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Color(0xFFE215AB), Color(0xFFE527FE)],
              //   stops: [0, 1], // 调整渐变范围
              // ),
              borderRadius: BorderRadius.circular(16)
            ),
          ),
          Container(
            height: 106,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
            ),
            child: Column(children: [
              SizedBox(height: 14),
              Text('Oracle', style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700)),
              SizedBox(height: 2),
              Text('Advanced users', style: TextStyle(color: Color(0xFF494D55), fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 12),
              SizedBox(width: 72, height: 24, child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: null,
                child: Text('Learn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              ))
            ]),
          ),
          Positioned(top: -16, child: Image.asset('assets/icons/tab_oracle_disabled.png', width: 56))
        ],
      ),
    );
  }

  Widget DailyTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Task', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(children: [
            Text('Complete a Lesson', style: TextStyle(color: Color(0xFF15171C), fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Text('+200', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            SizedBox(width: 2),
            Image.asset('assets/icons/xp.png', width: 16),
            Spacer(),
            SizedBox(width: 54, height: 24, child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF15171C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Text('Claim', style: TextStyle(fontWeight: FontWeight.w500))
            )),
          ]),
        ),
        SizedBox(height: 8),
        Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(children: [
            Text('Complete a Duel', style: TextStyle(color: Color(0xFF15171C), fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Text('+200', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            SizedBox(width: 2),
            Image.asset('assets/icons/xp.png', width: 16),
            Spacer(),
            SizedBox(width: 54, height: 24, child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF15171C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Text('Claim', style: TextStyle(fontWeight: FontWeight.w500))
            )),
          ]),
        )
      ]
    );
  }

  Widget CommonSense() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Common Sense', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(7, (index) => GestureDetector(
            onTap: () {
              SenseController.readSense(index);
              Get.toNamed('/common_sense');
            },
            child: Image.asset('assets/images/bg/sense_${index+1}.png', width: MediaQuery.of(context).size.width / 2 - 20),
          ))
        )
      ],
    );
  }
}