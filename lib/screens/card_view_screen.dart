import 'package:flutter/material.dart';

class CardViewScreen extends StatelessWidget {
  final VoidCallback onBack;

  const CardViewScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card View Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: const Center(child: Text('Card View Screen Content')),
    );
  }
}
