import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../core/widgets/custom_button.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({super.key});

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String screenshotPath = "";

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Funds")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 10),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // For now we just simulate screenshot selection
                setState(() {
                  screenshotPath = "assets/screenshot_placeholder.png";
                });
              },
              child: const Text("Attach Screenshot"),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Submit",
              onPressed: () async {
                if(nameController.text.isEmpty || emailController.text.isEmpty || screenshotPath.isEmpty){
                  return;
                }

                bool success = await walletProvider.deposit(
                  name: nameController.text,
                  email: emailController.text,
                  screenshot: screenshotPath,
                );

                if(success && context.mounted){
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}