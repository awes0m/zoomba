import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoomba/resources/jitsi_meet_methods.dart';
import 'package:zoomba/screens/video_call_screen.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/utils.dart';
import '../widgets/custom_neu_icon_button.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  void dispose() {
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = "room${random.nextInt(100000000) + 10000000}";
    try {
      _jitsiMeetMethods.createMeeting(
        roomName: roomName,
        isAudioMuted: true,
        isVideoMuted: true,
      );
    } catch (e) {
      showSnackBar(context, 'error: ${e.toString()}');
    }
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, VideoCallScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: ScrnSizer.screenHeight() * 0.04),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomNeuIconButton(
            icon: Icons.videocam,
            label: 'New\nMeeting',
            backgroundColor: backgroundColor,
            onPressed: createNewMeeting,
          ),
          CustomNeuIconButton(
            icon: Icons.add_box_rounded,
            label: 'Join\nMeeting',
            backgroundColor: backgroundColor,
            onPressed: () => joinMeeting(context),
          ),
          CustomNeuIconButton(
              icon: Icons.calendar_today,
              label: 'Schedule',
              backgroundColor: backgroundColor,
              onPressed: () {}),
          CustomNeuIconButton(
              icon: Icons.arrow_upward_rounded,
              label: 'Share\nScreen',
              backgroundColor: backgroundColor,
              onPressed: () {}),
        ],
      ),
      Expanded(
          child: Center(
        child: Text(
          "Create and Join Meetings \n\nin Just a Click !",
          textAlign: TextAlign.center,
          style: AppTextStyle.hintTextStyle(),
        ),
      )),
    ]);
  }
}
