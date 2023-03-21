import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final Size size;
  final String text;
  final Function onTapFunction;
  ButtonStyle? buttonStyle;
  CustomButton(
      {Key? key,
      required this.size,
      required this.text,
      required this.onTapFunction,
      this.buttonStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        style: buttonStyle,
        onPressed: () => onTapFunction(),
      ),
    );
  }
}
