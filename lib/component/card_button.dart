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
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
