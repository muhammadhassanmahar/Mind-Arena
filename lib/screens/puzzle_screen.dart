import 'package:flutter/material.dart';
import '../models/contest_model.dart';
import 'package:flutter_jigsaw_puzzle/flutter_jigsaw_puzzle.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contest = ModalRoute.of(context)!.settings.arguments as ContestModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Puzzle"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: JigsawPuzzle.network(
          imageUrl: contest.puzzleImage,
          rows: 3,
          columns: 3,
          onFinished: () {
            Navigator.pushNamed(context, "/result", arguments: contest);
          },
        ),
      ),
    );
  }
}