import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import "package:intl/intl.dart" show DateFormat;
import 'package:zoomba/resources/firestore_methods.dart';
import 'package:zoomba/utils/text_styles.dart';

class HistoryMeetingScreen extends StatelessWidget {
  static const routeName = '/history_meeting';
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireStoreMethods().meetingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Room Name:${(snapshot.data! as dynamic).docs[index]['meetingName']} ',
                    style: AppTextStyle.smallBold(),
                  ),
                  subtitle: Text(
                    'Joined on :${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['timestamp'].toDate())}',
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No meetings yet'),
            );
          }
        });
  }
}
