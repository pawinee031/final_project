import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 15.h,
        child: Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Text('oo'),
                ),
              ],
            ),
          ),
        ));
  }
}
