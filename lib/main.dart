import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/constants/colors.dart';

import 'providers/auth_provider.dart';
import 'providers/contest_provider.dart';
import 'providers/wallet_provider.dart';

import 'routes/app_routes.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const PuzzleContestApp());
}

class PuzzleContestApp extends StatelessWidget {
  const PuzzleContestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ContestProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Puzzle Contest",

        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: Colors.white,
        ),

        routes: AppRoutes.routes,

        home: const LoginScreen(),
      ),
    );
  }
}