import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../core/widgets/custom_button.dart';
import '../core/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 40),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Login",
              isLoading: authProvider.isLoading,
              onPressed: () async {

                bool success = await authProvider.login(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if(success && context.mounted){
                  Navigator.pushReplacementNamed(context, "/home");
                }
              },
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, "/signup");
              },
              child: const Text("Create Account"),
            )

          ],
        ),
      ),
    );
  }
}