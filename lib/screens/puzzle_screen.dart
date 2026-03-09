import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/contest_model.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final int gridSize = 3;

  late List<int> tiles;

  bool isCompleted = false;

  int remainingSeconds = 1800; // 30 minutes
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _generatePuzzle() {
    tiles = List.generate(gridSize * gridSize, (index) => index);
    tiles.shuffle(Random());
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer?.cancel();
        _timeUp();
      }
    });
  }

  void _timeUp() {
    if (!isCompleted) {
      final contest =
          ModalRoute.of(context)!.settings.arguments as ContestModel;

      Navigator.pushNamed(
        context,
        "/result",
        arguments: {
          "contest": contest,
          "failed": true,
          "time": 1800
        },
      );
    }
  }

  bool _isSolved() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != i) return false;
    }
    return true;
  }

  void _swapTiles(int oldIndex, int newIndex) {
    setState(() {
      final temp = tiles[oldIndex];
      tiles[oldIndex] = tiles[newIndex];
      tiles[newIndex] = temp;
    });

    if (_isSolved() && !isCompleted) {
      isCompleted = true;

      timer?.cancel();

      final contest =
          ModalRoute.of(context)!.settings.arguments as ContestModel;

      int solveTime = 1800 - remainingSeconds;

      Future.delayed(const Duration(milliseconds: 400), () {
        Navigator.pushNamed(
          context,
          "/result",
          arguments: {
            "contest": contest,
            "failed": false,
            "time": solveTime
          },
        );
      });
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final contest =
        ModalRoute.of(context)!.settings.arguments as ContestModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Puzzle Challenge"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// TIMER
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Time Left: ${formatTime(remainingSeconds)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// PUZZLE GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: tiles.length,
                itemBuilder: (context, index) {
                  return DragTarget<int>(
                    onAccept: (fromIndex) {
                      _swapTiles(fromIndex, index);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Draggable<int>(
                        data: index,
                        feedback:
                            _buildTile(tiles[index], contest.puzzleImage),
                        childWhenDragging:
                            Container(color: Colors.grey.shade300),
                        child: _buildTile(
                          tiles[index],
                          contest.puzzleImage,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(int tileIndex, String imageUrl) {
    int row = tileIndex ~/ gridSize;
    int col = tileIndex % gridSize;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          alignment: Alignment(
            -1 + (2 * col + 1) / gridSize,
            -1 + (2 * row + 1) / gridSize,
          ),
        ),
      ),
    );
  }
}