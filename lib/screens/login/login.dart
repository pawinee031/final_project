import 'package:flutter/material.dart';
import 'package:project/actions/auth.dart';
import 'package:project/screens/admin/admin_main.dart';
import 'package:project/screens/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  InputDecoration getInputDecorator() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: InputBorder.none,
      errorText: '',
    );
  }

  _isUserLogin() async {
    print('check user login ');

    if (await Auth.isUserLogin()) {
      SharedPreferences sp = await SharedPreferences.getInstance();

      print(sp.getInt('isAdmin'));
      if (sp.getInt('isAdmin') == 1)
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMain(),
            ),
            (route) => false);
      else
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    // _isUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                    "https://img.freepik.com/vector-premium/ilustracion-dibujos-animados-edificio-hospital_75802-326.jpg"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: getInputDecorator().copyWith(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.mail,
                      )),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: getInputDecorator().copyWith(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      )),
                ),
              ],
            )),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () async {
                      Auth.signInWithEmailPassword(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Text("Login"),
                  ),
                )),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                    },
                    child: Text("Register"),
                  ),
                )),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
