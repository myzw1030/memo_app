import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key, required this.color, required this.press, required this.icon})
      : super(key: key);

  final Color color;
  final Function() press;
  // final Widget cardChild;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
