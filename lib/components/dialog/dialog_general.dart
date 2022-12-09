import 'package:flutter/material.dart';
import 'package:project/components/dialog/error_dialog_widget.dart';

void showErrorDialog(BuildContext context, {String message = ""}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, _, __) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ErrorDialog(message: message),
      ),
    ),
  );
}

void showSelectionDialog(BuildContext context,
    {String title = "", String message = "", required VoidCallback onConfirm}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, _, __) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(message),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[500]),
                        onPressed: onConfirm,
                        child: Text(
                          'Confirm',
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700]),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    ),
  );
}
