import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Text('Error Occured'),
        ),
        ConstrainedBox(
            constraints: BoxConstraints(minHeight: 90),
            child: Row(
              children: [Expanded(child: Text(message))],
            )),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close')))
          ],
        )
      ],
    );
  }
}
