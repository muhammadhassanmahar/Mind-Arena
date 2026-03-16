import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contest_provider.dart';
import '../models/contest_model.dart';
import '../core/constants/colors.dart';
import '../core/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      Provider.of<ContestProvider>(context, listen: false).fetchContests();
    });
  }

  @override
  Widget build(BuildContext context) {

    final contestProvider = Provider.of<ContestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Puzzle Contests"),
        backgroundColor: AppColors.primary,
      ),
      body: contestProvider.isLoading
          ? const LoadingWidget()
          : contestProvider.contests.isEmpty
              ? const Center(
                  child: Text(
                    "No contests available today",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: contestProvider.contests.length,
                  itemBuilder: (context, index) {

                    ContestModel contest =
                        contestProvider.contests[index];

                    return Card(
                      margin: const EdgeInsets.all(12),
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          "Entry Fee: ${contest.entryFee}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Players: ${contest.playersJoined}/${contest.maxPlayers}",
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/contestDetail",
                              arguments: contest,
                            );
                          },
                          child: const Text("Join"),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}