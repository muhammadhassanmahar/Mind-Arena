import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../core/widgets/custom_button.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  String accountType = "Bank";

  @override
  Widget build(BuildContext context) {

    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Withdraw Funds")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 10),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 10),
            TextField(controller: accountNumberController, decoration: const InputDecoration(labelText: "Account Number")),
            const SizedBox(height: 10),
            TextField(controller: amountController, decoration: const InputDecoration(labelText: "Amount"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),

            DropdownButton<String>(
              value: accountType,
              items: ["Bank", "Easypaisa", "Jazzcash"].map((e) =>
                DropdownMenuItem(value: e, child: Text(e))
              ).toList(),
              onChanged: (value){
                setState(() {
                  accountType = value!;
                });
              },
            ),

            const SizedBox(height: 20),
            CustomButton(
              text: "Submit Withdraw Request",
              onPressed: () async {
                bool success = await walletProvider.withdraw(
                  name: nameController.text,
                  email: emailController.text,
                  amount: double.tryParse(amountController.text) ?? 0,
                  accountType: accountType,
                  accountNumber: accountNumberController.text,
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