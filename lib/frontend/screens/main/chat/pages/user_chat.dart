import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user/lib.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserChattingScreen extends StatefulWidget {
  static Route route(
    String id,
    ChatModel chatModel
  ) => MaterialPageRoute(
    builder: (context) => UserChattingScreen(id: id, chatModel: chatModel)
  );

  final String id;
  final ChatModel chatModel;
  const UserChattingScreen({super.key, required this.id, required this.chatModel});

  @override
  State<UserChattingScreen> createState() => _UserChattingScreenState();
}

class _UserChattingScreenState extends State<UserChattingScreen> {
  io.Socket? socket;
  late Directory appDirectory;
  TextEditingController text = TextEditingController();
  ScrollController scroll = ScrollController();
  late final RecorderController recorder;
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  FocusNode focus = FocusNode();
  List<MessageModel> messages = [];
  late MessageModel model;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool emojiShowing = false;
  bool isPaused = false;
  bool sendButton = false;
  bool isSender = false;
  Duration playDuration = Duration.zero;
  Duration playPosition = Duration.zero;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus) setState(() => emojiShowing = false);
    }); //Keyboard listener
    text.addListener(() {
      if(text.value.text.isNotEmpty){
        setState(() => sendButton = true);
      } else {
        setState(() => sendButton = false);
      }
    });
    _getDir();
    _initialiseControllers();
    controller = PlayerController();
    model = MessageModel(
      time: DateTime.now().minute.toString(),
      isAudio: false,
      isSender: false,
    );
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
    connectBackend();
  }

  @override
  void dispose() {
    recorder.dispose();
    focus.dispose();
    text.dispose();
    playerStateSubscription.cancel();
    if (model.isLastWidget) {
      controller.stopAllPlayers();
    }
    controller.dispose();
    super.dispose();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorder = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _preparePlayer() async {
    if (model.index == null && model.path == null) {
      return;
    }
    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: model.path!,
      shouldExtractWaveform: model.index?.isEven ?? true,
    );
    // Extracting waveform separately if index is odd.
    if (model.index?.isOdd ?? false) {
      controller.extractWaveformData(
        path: model.path!,
        noOfSamples: playerWaveStyle.getSamplesForWidth(model.width ?? 200),
      );
    }
  }


  void connectBackend() {
    socket = io.io(serverLink, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect().onerror(debugShow("Socket Error in Connection"));
    socket?.onConnect((data) {
      debugShow("Socket Connection: ${data.toString()}");
      socket?.on("message", (msg) {
        debugShow("My message: $msg");
        // setMessageList("source", msg["message"]);
        scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
      });
    });
    debugShow("Socket Connected: ${socket?.connected}");

    socket?.emit("signin", currentUserInfo?.serchID);
    // socket?.emit("/test", "Hello world");
  }

  void sendMessage({required String message, required String senderID, required String receiverID}) {
    // setMessageList("source", message);
    socket?.emit("message", {
      "message": message,
      "senderID": senderID,
      "receiverID": receiverID,
    });
    debugShow("Socket ID: ${socket?.id}");
    text.clear();
    setState(() => sendButton = false);
    scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
    // scroll.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  timeTeller() {
    final date = DateTime.now();
    if(date.second < 60){
      // final seconds = date.subtract(Duration(seconds: date.second));
      debugPrint(timeago.format(date));
    }
    final fifteenAgo = DateTime.now().subtract(const Duration(minutes: 15));
    debugPrint(timeago.format(fifteenAgo));
  }

  var timeSent = DateTime.now().hour + DateTime.now().minute;

  // void setMessageList(String type, String message){
  //   MessageModel messageModel = MessageModel(
  //     type: type,
  //     message: message,
  //     time: timeTeller()
  //   );
  //   setState(() {
  //     messages.add(messageModel);
  //   });
  // }

  void sendMsg({required MessageModel model, MessageModel? modelDate}) {
    setState(() {
      if(DateTime.now().hour == 3){
        messages.add(modelDate!);
      }
      messages.add(model);
    });
    text.clear();
    setState(() {
      sendButton = false;
      isSender = !isSender;
    });
    scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  //To open emoji picker or keyboard
  void open(){
    setState(() => emojiShowing = !emojiShowing);
    if(emojiShowing == true){
      focus.unfocus();
      focus.canRequestFocus = false;
    } else {
      setState(() => emojiShowing = false);
      if(emojiShowing == false){
        focus.requestFocus();
      }
    }
  }

  void startRecording() async {
    try {
      await recorder.record();
      timeTeller();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = true;
        isPaused = false;
      });
    }
  }

  void pauseRecording() async {
    try {
      if(isRecording){
        await recorder.pause();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = false;
        isPaused = true;
      });
    }
  }

  void resumeRecording() async {
    try {
      if(isPaused){
        await recorder.record();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isPaused = false;
        isRecording = true;
      });
    }
  }

  void stopRecordingAndSend() async {
    if (isRecording || isPaused) {
      recorder.reset();
      final newPath = await recorder.stop();
      if (newPath != null) {
        isRecordingCompleted = true;
        setState(() => path = newPath);
        sendMsg(model: MessageModel(
          path: path,
          time: MessageTime.getTime(),
          isAudio: true,
          isSender: isSender
        ));
        setState(() {
          isRecording = false;
          isPaused = false;
        });
        debugPrint("Recorded file size: ${File(newPath).lengthSync()}");
        debugPrint(newPath);
      }
    }
  }

  void deleteRecording() {
    recorder.reset();
    recorder.refresh();
    setState(() {
      isRecording = false;
      isPaused = false;
    });
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading
    ? const Center(child: CircularProgressIndicator())
    : KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(width, 70),
          child: ChatAppBar(chatModel: widget.chatModel,)
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              // Expanded(
              //   child: SizedBox(
              //     height: height - 150,
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         controller: scroll,
              //         itemCount: messages.length + 1,
              //         itemBuilder: (context, index){
              //           if(index == messages.length){
              //             return const SizedBox(height: 70);
              //           }
              //           if(messages[index].type == "senderID"){
              //             return SendMessageCard(
              //               message: messages[index].message,
              //               messageDate: messages[index].time,
              //               messageStatus: messages[index].status == "Sent"
              //                 ? Icons.done_outlined
              //                 : messages[index].status == "Waiting" || messages[index].status == "Not Sent"
              //                 ? Icons.timer_10_select_outlined
              //                 : Icons.done_all_outlined,
              //               iconColor: messages[index].status == "Read"
              //               ? SColors.blue
              //               : SColors.grey
              //             );
              //           } else {
              //             return SendMessageCard(
              //               message: messages[index].message,
              //               messageDate: messages[index].time,
              //               messageStatus: messages[index].status == "Sent"
              //                 ? Icons.done_outlined
              //                 : messages[index].status == "Waiting" || messages[index].status == "Not Sent"
              //                 ? Icons.timer_10_select_outlined
              //                 : Icons.done_all_outlined,
              //               iconColor: messages[index].status == "Read"
              //               ? SColors.blue
              //               : SColors.grey
              //             );
              //             // return ReplyMessageCard(
              //             //   message: messages[index].message,
              //             //   messageDate: messages[index].time,
              //             // );
              //           }
              //         }
              //       ),
              //     )
              //   ),
              // ),
              Expanded(
                child: SizedBox(
                  height: height - 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scroll,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index){
                        if(index == messages.length){
                          return const SizedBox(height: 70);
                        } else {
                          return MessageCard(model: messages[index]);
                        }
                      }
                    )
                  )
                )
              ),

              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).backgroundColor,
                  child: isRecording && isPaused == false
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AudioWaveforms(
                              enableGesture: true,
                              size: Size(MediaQuery.of(context).size.width / 2, 50),
                              recorderController: recorder,
                              waveStyle: WaveStyle(
                                waveColor: Theme.of(context).primaryColorDark,
                                extendWaveform: true,
                                showMiddleLine: false,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                            ),
                          ),
                          const SizedBox(width: 5),
                          HeartBeating(beatsPerMinute: 60, child: const SText(text: "Recording", color: SColors.red, size: 18)),
                        ]
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => deleteRecording(),
                            child: const Icon(
                              CupertinoIcons.trash_fill,
                              size: 24,
                              color: SColors.hint
                            )
                          ),
                          InkWell(
                            onTap: () => pauseRecording(),
                            child: const Icon(
                              CupertinoIcons.pause_fill,
                              size: 24,
                              color: SColors.red
                            )
                          ),
                          InkWell(
                            onTap: () => stopRecordingAndSend(),
                            child: const CircleAvatar(
                              backgroundColor: SColors.lightPurple,
                              radius: 22,
                              child: Icon(
                                CupertinoIcons.paperplane_fill,
                                color: SColors.white,
                                size: 20
                              ),
                            ),
                          ),
                        ]
                      )
                    ]
                  )
                  : isRecording == false && isPaused
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),

                          //Play and pause Recorded file
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!controller.playerState.isPaused)
                              InkWell(
                                onTap: () async {
                                  controller.playerState.isPlaying
                                  ? await controller.pausePlayer()
                                  : await controller.startPlayer(finishMode: FinishMode.loop);
                                },
                                child: Icon(
                                  controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow,
                                  size: 32,
                                  color: Theme.of(context).primaryColorDark
                                )
                              ),
                              // final twoMinuteDigits = twoDigits(duration.inMinutes.remainder(60));
                              //       final twoSecondDigits = twoDigits(duration.inSeconds.remainder(60));
                              const SizedBox(width: 5),
                              Expanded(
                                child: AudioFileWaveforms(
                                  size: Size(MediaQuery.of(context).size.width / 1, 50),
                                  playerController: controller,
                                  waveformType: model.index?.isOdd ?? false ? WaveformType.fitWidth : WaveformType.fitWidth,
                                  playerWaveStyle: playerWaveStyle,
                                  backgroundColor: Theme.of(context).backgroundColor
                                ),
                              ),
                              // SText(
                              //   text: recordedIsPlaying ? formatTime(playPosition - playDuration) : formatTime(playDuration),
                              //   color: SColors.hint,
                              //   size: 16
                              // )
                            ]
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => deleteRecording(),
                              child: const Icon(
                                CupertinoIcons.trash_fill,
                                size: 24,
                                color: SColors.hint
                              )
                            ),
                            InkWell(
                              onTap: () => resumeRecording(),
                              child: const Icon(
                                CupertinoIcons.mic_solid,
                                size: 24,
                                color: SColors.red
                              )
                            ),
                            InkWell(
                              onTap: () => stopRecordingAndSend(),
                              child: const CircleAvatar(
                                backgroundColor: SColors.lightPurple,
                                radius: 22,
                                child: Icon(
                                  CupertinoIcons.paperplane_fill,
                                  color: SColors.white,
                                  size: 20
                                ),
                              ),
                            ),
                          ]
                        )
                      ]
                    )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                focusNode: focus,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                                cursorColor: Theme.of(context).primaryColor,
                                controller: text,
                                maxLines: 5,
                                minLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                maxLengthEnforcement: MaxLengthEnforcement.none,
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                // enabled: enabled,
                                // textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                // validator: validate,
                                // onChanged: (value) => value.isNotEmpty
                                // ? setState(() => sendButton = true)
                                // : setState(() => sendButton = false),
                                decoration: InputDecoration(
                                  hintText: "Start typing...",
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    color: SColors.hint,
                                  ),
                                  isDense: true,
                                  filled: true,
                                  prefixIcon: InkWell(
                                    onTap: () => open(),
                                    child: Icon(
                                      emojiShowing == false ? FontAwesomeIcons.solidFaceGrin
                                      : FontAwesomeIcons.solidKeyboard
                                      ,
                                      color: SColors.hint
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 1.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            // onTap: () => showMore(context),
                                            onTap: () => showMore(context),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Transform.rotate(
                                                angle: 120,
                                                child: Icon(
                                                  Icons.attach_file_rounded,
                                                  color: Theme.of(context).primaryColorLight,
                                                  size: 24
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(isRecording == false)
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () => Get.to(() => const CameraScreen()),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                color: Theme.of(context).primaryColorLight,
                                                size: 24
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      width: 1.8,
                                      color: Theme.of(context).disabledColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: SColors.lightPurple,
                            radius: 22,
                            child: GestureDetector(
                              onTap: () => sendButton ? sendMsg(
                                model: MessageModel(
                                  message: text.text,
                                  time: MessageTime.getTime(),
                                  isAudio: false,
                                  isSender: isSender
                                ),
                                // modelDate: DateLabel(model: )
                              ) : startRecording(),
                              child: Icon(
                                // sendButton ? CupertinoIcons.paperplane_fill : CupertinoIcons.waveform,
                                sendButton || isRecording ? Icons.send : Icons.mic,
                                color: SColors.white,
                                size: sendButton ? 22 : 26
                              ),
                            ),
                          )
                        ],
                      ),
                      emojiShowing ? SlideInUp(child: PickEmoji(text: text, height: height / 2.5)) : Container()
                    ],
                  )
                )
              )
            ]
          )
        ),
      ),
    );
  }
}
