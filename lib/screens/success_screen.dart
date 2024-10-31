// screens/success_screen.dart
import 'package:flutter/material.dart';
import 'package:quick_inv/main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.succMsg});
  final String succMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            Text(
              succMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 15),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              ),
              child: const Text("Back to Main"),
            )
          ],
        ),
      ),
    );
  }
}
