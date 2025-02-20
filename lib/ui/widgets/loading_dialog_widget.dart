import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: const CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(height: 16),
            Text(
              "Loading",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
