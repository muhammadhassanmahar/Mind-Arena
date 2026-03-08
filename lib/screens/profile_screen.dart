import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../core/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text("Name: ${authProvider.user?.displayName ?? "N/A"}"),
            const SizedBox(height: 10),
            Text("Email: ${authProvider.user?.email ?? "N/A"}"),
            const SizedBox(height: 30),

            CustomButton(
              text: "Logout",
              onPressed: () async {
                await authProvider.logout();
                if(context.mounted){
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}