// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';
import 'package:get/get.dart';

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
              Icon(Icons.arrow_forward_ios_rounded, size: 18)
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
                    children: [
                      Container(
                        width: 177,
                        height: 184,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/bg/square_blue.png'))
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                                child: Image.asset('assets/icons/star_ac.png', width: 24),
                              ),
                              Image.asset('assets/icons/arrow_north_east.png', width: 32)
                            ]
                          ),
                          SizedBox(height: 12),
                          Text('Discussing key features like decentralization, security, and transparency.', style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700, height: 1.2)),
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
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(0xFF282B32),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                              )
                            ]),
                          )
                        ]),
                      ),
                    ],
                  ),
                )
              );
            }
          )
        ],
      ),
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
              Text('More', style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.w500))
            ],
          ),
          SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/chapter');
                },
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
                      Text('Chapter 1:', style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text('What is cryptocurrency?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
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
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(10, (index) => Chapter_item())
    );
  }
  Widget Chapter_item() {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24,
      height: 106,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(children: [
        Text('Introduction to Digital Currency', style: TextStyle(color: Color(0xFF282B32), fontWeight: FontWeight.w700, height: 1.1)),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('4 topic', style: TextStyle(color: Color(0xFF494D55), fontSize: 12, fontWeight: FontWeight.w500)),
            Text('5% complete', style: TextStyle(color: Color(0xFF494D55), fontSize: 11, fontWeight: FontWeight.w400)),
          ]
        ),
        SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFF282B32),
                borderRadius: BorderRadius.circular(8)
              ),
            )
          ]),
        )
      ]),
    );
  }
}