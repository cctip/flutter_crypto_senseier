import 'package:flutter/material.dart';
import 'package:flutter_crypto_senseier/widget/user.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({super.key});

  @override
  State<BattlePage> createState() => BattlePageState();
}

class BattlePageState extends State<BattlePage> {
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
                    onPressed: () {},
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