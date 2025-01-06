import 'package:flutter/material.dart';

class DynamicItemDetailsView extends StatelessWidget {
  const DynamicItemDetailsView({super.key});

  static const routeName = '/dynamic_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
