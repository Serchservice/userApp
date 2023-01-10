import 'package:flutter/material.dart';
import 'package:user/lib.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  @override
  void initState() {
    super.initState();
    SerchUser.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSign,
      callID: "123456",
      userID: "ieoyquoqw",
      userName: "Evaristus",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..layout = ZegoLayout.pictureInPicture(
          switchLargeOrSmallViewByClick: true,
        )
        ..onHangUpConfirmation = (BuildContext context) async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                title: SText(text: "Are you sure you want to end this call?", color: Theme.of(context).primaryColor, size: 18),
                // content: const Text(
                //     "You can customize this dialog however you like",
                //     style: TextStyle(color: Colors.white70)),
                actions: [
                  SBtn(
                    text: "Yes, am done", textSize: 16,
                    buttonColor: Theme.of(context).backgroundColor,
                    textColor: SColors.lightPurple,
                    onClick: () => Navigator.of(context).pop(true)
                  ),
                  SBtn(
                    text: "No, continue", textSize: 16,
                    onClick: () => Navigator.of(context).pop(false),
                    buttonColor: Theme.of(context).backgroundColor,
                    textColor: SColors.lightPurple,
                  )
                ],
              );
            },
          );
        }
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = false
        ..turnOnCameraWhenJoining = true,
    );
  }
}