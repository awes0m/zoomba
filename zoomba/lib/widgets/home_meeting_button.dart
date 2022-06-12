import 'package:flutter/material.dart';
import 'package:zoomba/utils/colors.dart';

class HomeMeetingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const HomeMeetingButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          width: 60,
          height: 60,
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        )
      ]),
    );
  }
}
