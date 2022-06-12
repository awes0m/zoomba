import 'package:flutter/material.dart';
import 'package:zoomba/utils/text_styles.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChanged;
  const MeetingOption(
      {Key? key,
      required this.text,
      required this.isMute,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScrnSizer.screenHeight() * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: AppTextStyle.smallBold(),
            ),
          ),
          Switch.adaptive(
            value: isMute,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
