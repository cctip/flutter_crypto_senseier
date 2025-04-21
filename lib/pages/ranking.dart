import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
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
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Colors.white,
          child: UserBox(theme: 'light')
        ),
        Expanded(child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top - 56,
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
                  Positioned(top: 158, child: Stack(
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64),
                            color: Color(0xFFe0e0e0)
                          ),
                          child: Icon(Icons.question_mark_rounded, color: Colors.black38, size: 32),
                        ),
                      ),
                      Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_1.png', width: 24))
                    ],
                  )),
                  Positioned(top: 190, left: 80, child: Stack(
                    clipBehavior: Clip.none,
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64),
                            color: Color(0xFFe0e0e0)
                          ),
                          child: Icon(Icons.question_mark_rounded, color: Colors.black38),
                        ),
                      ),
                      Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_2.png', width: 16))
                    ],
                  )),
                  Positioned(top: 190, right: 80, child: Stack(
                    clipBehavior: Clip.none,
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64),
                            color: Color(0xFFe0e0e0)
                          ),
                          child: Icon(Icons.question_mark_rounded, color: Colors.black38),
                        ),
                      ),
                      Positioned(top: -2, right: -2, child: Image.asset('assets/icons/rank_3.png', width: 16))
                    ],
                  )),
                  Positioned(top: 232, child: Image.asset('assets/images/bg/rank_bg.png', width: 302, fit: BoxFit.cover)),
                  Positioned(top: 325, child: Container(
                    width: 370,
                    height: 232,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Text('The leaderboard is empty... for now.', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)),
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
                            onPressed: () {},
                            child: Text('Learning', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                          ),
                        ),
                      ],
                    ),
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
}