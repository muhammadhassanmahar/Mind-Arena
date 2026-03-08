import 'package:flutter/material.dart';
import '../models/contest_model.dart';
import '../core/widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contest = ModalRoute.of(context)!.settings.arguments as ContestModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Congratulations!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            Text("Contest Entry Fee: ${contest.entryFee} Rs"),
            const SizedBox(height: 20),
            Text("You have completed the puzzle!"),

            const SizedBox(height: 40),
            CustomButton(
              text: "Go to Home",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}