import 'package:flutter/material.dart';
import '../models/contest_model.dart';
import '../core/widgets/custom_button.dart';
import '../core/constants/colors.dart';

class ContestDetailScreen extends StatelessWidget {
  const ContestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contest = ModalRoute.of(context)!.settings.arguments as ContestModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contest Detail"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Entry Fee: ${contest.entryFee} Rs",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Players: ${contest.playersJoined}/${contest.maxPlayers}",
            ),
            const SizedBox(height: 10),
            Text(
              "Status: ${contest.status}",
            ),
            const SizedBox(height: 20),

            CustomButton(
              text: "Join Contest",
              onPressed: () {
                Navigator.pushNamed(context, "/waitingRoom", arguments: contest);
              },
            )
          ],
        ),
      ),
    );
  }
}