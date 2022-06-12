import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoomba/resources/jitsi_meet_methods.dart';
import 'package:zoomba/utils/colors.dart';
import 'package:zoomba/utils/text_styles.dart';
import 'package:zoomba/widgets/meeting_option.dart';

import '../utils/utils.dart';
import '../widgets/app_text_field_widget.dart';

class VideoCallScreen extends StatefulWidget {
  static const routeName = '/video_call';
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController meetingIdController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      displayName: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Join a meeting',
          style: AppTextStyle.mediumBold(),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Top Space
          SizedBox(height: ScrnSizer.screenHeight() * 0.04),
          AppTextField(
            title: 'Room Id',
            hintText: 'Id of Room to join',
            controller: meetingIdController,
          ),
          AppTextField(
            title: 'Name',
            hintText: 'Room Name',
            controller: nameController,
          ),
          // Bottom Space
          SizedBox(height: ScrnSizer.screenHeight() * 0.04),
          InkWell(
              onTap: _joinMeeting,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Join', style: AppTextStyle.mediumBold()),
              )),
          SizedBox(height: ScrnSizer.screenHeight() * 0.04),
          MeetingOption(
            text: 'Mute Audio',
            isMute: isAudioMuted,
            onChanged: onAudioMuted,
          ),
          MeetingOption(
            text: 'Turn off My Video',
            isMute: isVideoMuted,
            onChanged: onVideoMuted,
          ),
        ]),
      ),
    );
  }

  void onAudioMuted(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  void onVideoMuted(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }
}
