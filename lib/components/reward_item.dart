import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/confirmation_dialog.dart';
import 'package:project/models/reward.dart';

class RewardItem extends StatelessWidget {
  final int currentPoint;
  final Reward? rewardItem;
  const RewardItem({super.key, this.rewardItem, required this.currentPoint});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(rewardItem!.name.toString()),
                  Spacer(),
                  Text("${rewardItem!.pointRequire} ฿"),
                  TextButton(
                      onPressed: currentPoint < rewardItem!.pointRequire!
                          ? null
                          : () async {
                              showGeneralDialog(
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return ConfirmationDialog(
                                    title:
                                        "Exchange ${rewardItem!.pointRequire} Reward Point",
                                    confirmText: "Exchange",
                                    description:
                                        Text("Do you want to exchange reward?"),
                                    onConfirm: () async {
                                      print('แลก');
                                      final bool response =
                                          await FirestoreActions()
                                              .exchangeReward(
                                                  pointToDeduct: rewardItem!
                                                      .pointRequire!);

                                      if (response) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.green[600],
                                                content: Text(
                                                    'Exchange Reward : Successfully')));
                                      }
                                    },
                                  );
                                },
                              );
                            },
                      child: Text('แลก'))
                ],
              ),
            ],
          )),
    );
  }
}
