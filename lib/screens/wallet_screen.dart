import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/loading_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).fetchWallet();
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: walletProvider.isLoading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Balance: ${walletProvider.wallet?.balance ?? 0} Rs",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),

                  CustomButton(
                    text: "Add Funds",
                    onPressed: () {
                      Navigator.pushNamed(context, "/addFunds");
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Withdraw",
                    onPressed: () {
                      Navigator.pushNamed(context, "/withdraw");
                    },
                  ),
                ],
              ),
            ),
    );
  }
}