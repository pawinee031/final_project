import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/actions/auth.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/coin_widget.dart';
import 'package:project/components/square_btn.dart';
import 'package:project/screens/home/booking_list/booking_list_page.dart';
import 'package:project/screens/home/coin/coin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';

class MainSection extends StatefulWidget {
  MainSection({Key? key}) : super(key: key);

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  bool isLogin = false;
  int rp = 0;
  getPoint() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString('uid') != null) {
      final point =
          await FirestoreActions().getReward(sp.getString('uid') ?? "");

      setState(() {
        rp = point;
      });
    }
  }

  initialAction() async {
    bool response = await Auth.isUserLogin();
    setState(() {
      isLogin = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      initialAction();
      getPoint();
    }
  }

  List<String> images = [
    "https://i.pinimg.com/564x/e1/be/da/e1beda4a5b97a31b4053b3ff64e4848c.jpg",
    "https://www.creativefabrica.com/wp-content/uploads/2020/01/05/Doctor-medical-check-up-for-healthcare-Graphics-1-32.jpg",
    "https://static.vecteezy.com/system/resources/previews/002/127/134/original/medical-and-healthcare-concept-illustration-schedule-medical-check-up-flat-design-with-doctor-can-use-for-the-homepage-mobile-apps-character-cartoon-illustration-flat-style-free-vector.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CoinWidget(point: rp),
              ),
              SizedBox(height: 25),
              CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: images.map((
                  image,
                ) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  image,
                                )),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5)),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(children: [
                      SizedBox(
                        width: 25,
                      ),
                      Image.asset(
                        'assets/images/drugs.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "ความรู้เกี่ยวกับยาทั่วไป",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                    ]),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingListPage(),
                      ));
                },
              ),
              InkWell(
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(children: [
                      SizedBox(
                        width: 25,
                      ),
                      Image.asset(
                        'assets/images/medal.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "แลกคะแนนสะสม",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                    ]),
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoinPage(),
                      ));

                  getPoint();
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(25.0),
              //   child: GridView.count(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 10,
              //     crossAxisSpacing: 20,
              //     children: [
              //       SquareButton(
              //           child: Text('ความรู้เกี่ยวกับยาทั่วไป'),
              //           onTap: () {

              //           }),
              //       // SquareButton(child: Text('ลำดับคิว')),
              //       SquareButton(
              //         child: Text('แลกคะแนนสะสม'),
              //         onTap: () async {
              // await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CoinPage(),
              //     ));

              // getPoint();
              //         },
              //       ),
              //       // SquareButton(child: Text('ความรู้เกี่ยวยาทั่วไป')),
              //       // SquareButton(child: Text('ติดต่อเรา')),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        if (!isLogin)
          Container(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                            child: Text('เข้าสู่ระบบ'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ));
                            }),
                      ),
                    ),
                  ],
                )),
          ),
      ],
    );
  }
}
