import 'package:flutter/material.dart';

class CircularLoadWidget extends StatelessWidget {
  const CircularLoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
