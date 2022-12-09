import 'dart:developer';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:project/actions/auth.dart';
import 'package:project/components/dialog/dialog_general.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPaswordController = TextEditingController();
  int age = 0;

  InputDecoration getInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
    errorText: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 235, 235),
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration:
                          getInputDecoration.copyWith(hintText: "First Name"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _surnameController,
                      decoration:
                          getInputDecoration.copyWith(hintText: "Surname"),
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: _dobController,
                decoration: getInputDecoration.copyWith(hintText: "Birthday"),
                readOnly: true,
                onTap: () async {
                  try {
                    final dob = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(Duration(days: 365 * 100)),
                        lastDate: DateTime.now());

                    if (dob != null) {
                      _dobController.text =
                          "${dob.year}-${dob.month}-${dob.day}";

                      setState(() {
                        age = AgeCalculator.age(dob).years;

                        if (age <= 0) {
                          throw Exception('age error age must > 0');
                        }
                        log(age.toString());
                      });
                    }
                  } catch (err) {
                    showErrorDialog(context,
                        message: err.toString().split(":").last);
                  }
                },
              ),
              TextFormField(
                controller: _mobileNoController,
                decoration: getInputDecoration.copyWith(hintText: "Mobile No."),
              ),
              TextFormField(
                controller: _mailController,
                decoration: getInputDecoration.copyWith(hintText: "E-Mail"),
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: getInputDecoration.copyWith(hintText: "Password"),
              ),
              TextFormField(
                obscureText: true,
                controller: _confirmPaswordController,
                decoration:
                    getInputDecoration.copyWith(hintText: "Confirm Password"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Auth.signUpWithEmail(
                            mobileNo: _mobileNoController.text.trim(),
                            age: age,
                            birthdate: _dobController.text.trim(),
                            firstName: _firstNameController.text.trim(),
                            lastName: _surnameController.text.trim(),
                            email: _mailController.text.trim(),
                            password: _passwordController.text.trim())
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
