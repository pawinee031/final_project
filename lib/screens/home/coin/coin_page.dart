import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/appcolor.dart';
import 'package:project/components/coin_progress.dart';
import 'package:project/components/reward_item.dart';
import 'package:project/components/square_btn.dart';
import 'package:project/models/reward.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  String fullname = "";
  int point = 0;
  getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String firstName = sharedPreferences.getString('firstName') ?? "";
    String lastName = sharedPreferences.getString('lastName') ?? "";
    setState(() {
      fullname = "$firstName" + " " + "$lastName";
    });
  }

  getPoint() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final int response =
        await FirestoreActions().getReward(sp.getString('uid') ?? "");
    setState(() {
      point = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getPoint();
  }

  @override
  Widget build(BuildContext context) {
    List<Reward> rewards = [
      Reward(
          pointRequire: 250,
          name: "กระติกน้ำร้อน 25000 P Coupon",
          type: "reward"),
      Reward(
          pointRequire: 100, name: "กระเป๋าถือ 10000 P Coupon", type: "reward"),
      Reward(pointRequire: 10, name: "1,000 P Coupon", type: "coupon"),
      Reward(pointRequire: 5, name: "500 P Coupon", type: "coupon"),
      Reward(pointRequire: 4, name: "400 P Coupon", type: "coupon"),
      Reward(pointRequire: 3, name: "300 P Coupon", type: "coupon"),
      Reward(pointRequire: 2, name: "200 P Coupon", type: "coupon"),
      Reward(pointRequire: 1, name: "100 P Coupon", type: "coupon"),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 75,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$fullname'),
            //Text('Full Name'),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text('Coupon and Reward Exchange',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                //   child: Text('Coupon',
                //       style:
                //           TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                // ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text('100 P Coupon = 1 ฿',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      if (rewards[index].type == "coupon")
                        return RewardItem(
                          rewardItem: rewards[index],
                          currentPoint: point,
                        );
                      else
                        return Container();
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text('Reward',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      if (rewards[index].type == "reward")
                        return RewardItem(
                          rewardItem: rewards[index],
                          currentPoint: point,
                        );
                      else
                        return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
