import 'package:flutter/material.dart';

class NumberCardWidget extends StatelessWidget {
  final String title;
  final String text;

  const NumberCardWidget({
    Key? key,
    required this.title,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text(text)
            ),
          ),
        ),
        Text(title),
      ],
    );
  }
}