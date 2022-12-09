import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final double borderRadius;
  final String title;
  final Widget? description;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  const ConfirmationDialog({
    Key? key,
    this.title = "Confirm this Action?",
    this.description,
    this.borderRadius = 15,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.confirmColor,
    this.cancelColor,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ButtonStyle> buttonStyle = [
      ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: confirmColor ?? Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: cancelColor ?? Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)))
    ];
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: description ?? const Text(""),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: ElevatedButton(
                  style: buttonStyle[0],
                  onPressed: onConfirm,
                  child: Text(confirmText),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                    style: buttonStyle[1],
                    onPressed: () {
                      onCancel ?? Navigator.pop(context);
                    },
                    child: Text(cancelText)),
              ),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
