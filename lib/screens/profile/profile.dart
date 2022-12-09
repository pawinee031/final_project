import 'package:flutter/material.dart';
import 'package:project/actions/auth.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName = "";
  String? lastName = "";
  String? email = "";
  int age = 0;
  String birthdate = "";
  String mobileNo = "";

  loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = sharedPreferences.getString('firstName') ?? "";
      lastName = sharedPreferences.getString('lastName') ?? "";
      email = sharedPreferences.getString('email') ?? "";
      age = sharedPreferences.getInt('age') ?? 0;
      birthdate = sharedPreferences.getString('birthdate') ?? "";
      mobileNo = sharedPreferences.getString('mobileNo') ?? "";
    });
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 35.w),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Fullname : $firstName $lastName',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          child: Text(
                        'Birthdate(YYYY-M-D) : $birthdate',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      )),
                      Container(
                          child: Text(
                        'Age : $age',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      )),
                      Container(
                          child: Text(
                        'Mobile No. : $mobileNo',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      )),
                      Container(
                          child: Text(
                        'E-mail : $email',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      )),
                    ],
                  ),
                )),
            Spacer(),
            Container(
              width: 100.w,
              height: 50,
              child: OutlinedButton(
                  onPressed: () async {
                    Auth.signout(context);
                  },
                  child: Text('Logout')),
            )
          ],
        ),
      ),
    );
  }
}
