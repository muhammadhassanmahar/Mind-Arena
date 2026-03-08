import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/contest_detail_screen.dart';
import '../screens/waiting_room_screen.dart';
import '../screens/puzzle_screen.dart';
import '../screens/result_screen.dart';
import '../screens/wallet_screen.dart';
import '../screens/add_funds_screen.dart';
import '../screens/withdraw_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    "/login": (context) => const LoginScreen(),
    "/signup": (context) => const SignupScreen(),
    "/home": (context) => const HomeScreen(),
    "/contestDetail": (context) => const ContestDetailScreen(),
    "/waitingRoom": (context) => const WaitingRoomScreen(),
    "/puzzle": (context) => const PuzzleScreen(),
    "/result": (context) => const ResultScreen(),
    "/wallet": (context) => const WalletScreen(),
    "/addFunds": (context) => const AddFundsScreen(),
    "/withdraw": (context) => const WithdrawScreen(),
    "/profile": (context) => const ProfileScreen(),
  };
}