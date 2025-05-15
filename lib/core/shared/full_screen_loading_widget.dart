import 'package:flutter/material.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  const FullScreenLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.shadow.withValues(alpha: .3),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
