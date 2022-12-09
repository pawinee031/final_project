import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  
  final String title;
  final Widget? description;
  final double borderRadius;
  final Color? buttonColor;
  const ErrorDialog({
    super.key,
    this.title = "Error Occured",
    this.borderRadius = 15,
    this.description,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    const double defaultSize = 15;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: defaultSize),
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: defaultSize, horizontal: 10),
            child: description ?? const Text(""),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: defaultSize),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: buttonColor ?? Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            )),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.25,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: defaultSize,
          )
        ],
      ),
    );
  }
}
