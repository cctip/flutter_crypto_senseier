// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CommonSense extends StatefulWidget {
  const CommonSense({super.key});

  @override
  State<CommonSense> createState() => CommonSenseState();
}
class CommonSenseState extends State<CommonSense> {
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
            title: Text('Common Sense', style: TextStyle(
              color: Color(0xFF15171C),
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          Expanded(child: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
              child: Column(children: [
              ]),
            ))
          ]))
        ],
      ),
    ));
  }
}