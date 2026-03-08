import 'package:flutter/material.dart';
import '../models/contest_model.dart';
import '../core/widgets/loading_widget.dart';
import '../core/constants/colors.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {

  int playersJoined = 0;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    simulateJoining();
  }

  void simulateJoining() async {
    // simulation of waiting players
    for(int i=0; i<20; i++){
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        playersJoined++;
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contest = ModalRoute.of(context)!.settings.arguments as ContestModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting Room"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Contest Entry Fee: ${contest.entryFee} Rs"),
            const SizedBox(height: 20),
            Text("Players Joined: $playersJoined/${contest.maxPlayers}"),
            const SizedBox(height: 20),

            isReady
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/puzzle", arguments: contest);
                    },
                    child: const Text("Start Puzzle"),
                  )
                : const LoadingWidget(message: "Waiting for players..."),
          ],
        ),
      ),
    );
  }
}