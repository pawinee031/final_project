import 'package:flutter/material.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/models/bookingV2.dart';
import 'package:project/providers/bookng_provider_v2.dart';
import 'package:project/providers/timeslot_provider.dart';
import 'package:project/screens/timeslot/components/timeslot.dart';
import 'package:project/screens/timeslot/timeslot_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BookForm extends StatefulWidget {
  const BookForm({super.key});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MaskTextInputFormatter telMask = MaskTextInputFormatter(
    mask: "###-###-####",
  );

  TextEditingController _telController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionC0ntroller = TextEditingController();
  InputDecoration getInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
    errorText: '',
  );
  loadUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    setState(() {
      _firstNameController.text = sp.getString('firstName') ?? "";
      _lastNameController.text = sp.getString('lastName') ?? "";
      _ageController.text = sp.getInt('age').toString();
      _telController.text = sp.getString('mobileNo') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();

    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Queue')),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Padding(
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
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not empty';
                        }

                        return null;
                      },
                      decoration: getInputDecoration.copyWith(
                        hintText: 'ชื่อ',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _lastNameController,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not empty';
                        }

                        return null;
                      },
                      decoration: getInputDecoration.copyWith(
                        hintText: 'สกุล',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _ageController,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not empty';
                        }

                        return null;
                      },
                      decoration: getInputDecoration.copyWith(
                        hintText: 'อายุ',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer()
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _telController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must not empty';
                        }

                        return null;
                      },
                      inputFormatters: [
                        telMask,
                      ],
                      decoration: getInputDecoration.copyWith(
                        hintText: 'เบอร์โทร',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      child: TextFormField(
                        controller: _descriptionC0ntroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must not empty';
                          }

                          return null;
                        },
                        minLines: 6,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: getInputDecoration.copyWith(
                          hintText: 'ลักษณะอาการ',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              TimeSlotProvider timeSlotProvider =
                                  Provider.of<TimeSlotProvider>(context,
                                      listen: false);
                              BookingProviderV2 provider =
                                  Provider.of<BookingProviderV2>(context,
                                      listen: false);

                              var bookingDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 30)));

                              if (bookingDate != null) {
                                String dateYYYYMMDD = bookingDate
                                    .toIso8601String()
                                    .split("T")
                                    .first;

                                List<String> blockedSlot =
                                    await FirestoreActions()
                                        .getBlockedTimeSlot(date: dateYYYYMMDD);
                                timeSlotProvider.setBlockedSlot(blockedSlot);
                                BookingV2 bookRequest = BookingV2();
                                bookRequest
                                  ..active = true
                                  ..uid = Uuid().v4();

                                bookRequest
                                  ..data = Data(
                                    user: User(
                                      age: _ageController.text,
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      mobile: _telController.text,
                                    ),
                                    desc: _descriptionC0ntroller.text,
                                  );

                                provider.booking = bookRequest;

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeSlotView(
                                              date: dateYYYYMMDD,
                                            )));
                              }
                            }
                          },
                          child: Text('Next')),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //     onPressed: () async {
              //       FirestoreActions().getBlockedTimeSlot(date: "2022-11-03");
              //     },
              //     child: Text('get blocked'))
            ],
          ),
        ),
      )),
    );
  }
}
