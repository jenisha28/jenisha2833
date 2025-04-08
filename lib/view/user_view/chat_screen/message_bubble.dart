import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/model/chat_model/chat_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
    required this.msgTime,
    required this.messageId,
    required this.msgType,
    required this.status,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
    required this.msgTime,
    required this.messageId,
    required this.msgType,
    required this.status,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  final MsgType msgType;
  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final String msgTime;
  final String messageId;
  final Status status;
  final bool isMe;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final chat = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        if (widget.userImage != null)
          Positioned(
            top: 15,
            right: widget.isMe ? 0 : null,
            child: !widget.isMe
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.userImage!,
                    ),
                    backgroundColor: theme.colorScheme.primary.withAlpha(180),
                    radius: 20,
                  )
                : Container(),
          ),
        Container(
          color: chat.selectedMessages.contains(widget.messageId)
              ? AppColors.lightBlue
              : null,
          margin: const EdgeInsets.only(left: 36),
          child: Row(
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (chat.time.contains(widget.messageId)) {
                          chat.time.remove(widget.messageId);
                        } else {
                          chat.time.add(widget.messageId);
                        }
                      });
                    },
                    onLongPress: () {
                      if (widget.isMe) {
                        chat.showCustomMenu(context, widget.messageId);
                      }
                    },
                    onTapDown: chat.storePosition,
                    child: SwipeTo(
                      onRightSwipe: (value) {
                        chat.onReply(widget.messageId);
                      },
                      offsetDx: 0.50,
                      animationDuration: Duration(milliseconds: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.isMe
                              ? AppColors.blue
                              : Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: !widget.isMe && widget.isFirstInSequence
                                ? Radius.zero
                                : const Radius.circular(12),
                            topRight: widget.isMe && widget.isFirstInSequence
                                ? Radius.zero
                                : const Radius.circular(12),
                            bottomLeft: const Radius.circular(12),
                            bottomRight: const Radius.circular(12),
                          ),
                        ),
                        constraints: const BoxConstraints(maxWidth: 200),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 14,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.msgType == MsgType.reply)
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                  bottom: 3,
                                  top: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border(
                                      left: BorderSide(
                                          color: Get.isDarkMode
                                              ? AppColors.blue
                                              : AppColors.darkBlue,
                                          width: 5)),
                                  color: AppColors.lightBlue,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            chat
                                                .getUser(chat
                                                    .getMessage(chat
                                                        .getMessage(
                                                            widget.messageId)
                                                        .replyTo)
                                                    .senderId)
                                                .username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    chat
                                                .getMessage(chat
                                                    .getMessage(
                                                        widget.messageId)
                                                    .replyTo)
                                                .type ==
                                            "image"
                                        ? Image.file(
                                            File(chat
                                                .getMessage(chat
                                                    .getMessage(
                                                        widget.messageId)
                                                    .replyTo)
                                                .imageMessage),
                                            fit: BoxFit.contain,
                                          )
                                        : Text(
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            chat
                                                .getMessage(chat
                                                    .getMessage(
                                                        widget.messageId)
                                                    .replyTo)
                                                .message,
                                            style: TextStyle(
                                                height: 1.3,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black),
                                          ),
                                  ],
                                ),
                              ),
                            chat
                                    .getMessage(widget.messageId)
                                    .imageMessage
                                    .isNotEmpty
                                ? Image.file(
                                    File(chat
                                        .getMessage(widget.messageId)
                                        .imageMessage),
                                    fit: BoxFit.contain,
                                  )
                                : SizedBox(),
                            SizedBox(
                                height: chat
                                            .getMessage(widget.messageId)
                                            .imageMessage
                                            .isNotEmpty &&
                                        widget.message.isNotEmpty
                                    ? 10
                                    : 0),
                            widget.message.isNotEmpty
                                ? Text(
                                    widget.message,
                                    style: TextStyle(
                                      height: 1.3,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: widget.isMe
                                          ? Colors.white
                                          : Get.isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                    softWrap: true,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  chat.time.contains(widget.messageId)
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 13,
                            right: 13,
                          ),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: DateFormat('jm')
                                    .format(DateTime.parse(widget.msgTime)),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Get.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                              widget.isMe
                                  ? TextSpan(
                                      text: " • ",
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? AppColors.white
                                              : AppColors.black),
                                    )
                                  : TextSpan(text: ""),
                              widget.isMe
                                  ? TextSpan(
                                      text: widget.status.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 12.5,
                                            color: Get.isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                          ))
                                  : TextSpan(text: ""),
                            ]),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlusMinusEntry extends PopupMenuEntry<int> {
  @override
  double height = 100;

  PlusMinusEntry(this.msgId, {super.key});
  final String msgId;
  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

  @override
  bool represents(int? value) => value == 1 || value == 2;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<PlusMinusEntry> {
  final chat = Get.put(ChatViewModel());
  void _delete() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
    Get.dialog(
      AlertDialog(
        title: Text("Sure to Delete Message?"),
        backgroundColor: AppColors.lightBlue,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: AppColors.darkBlue),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              chat.deleteMessage(widget.msgId);
              Get.back();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
    // chat.deleteMessage(widget.msgId);
  }

  void _edit() {
    Navigator.pop<int>(context, 2);
    chat.isUpdate.value = true;
    chat.focusNode.value.requestFocus();
    chat.updateMsgId.value = widget.msgId;
    chat.chatController.text = chat.getMessage(widget.msgId).message;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: _delete,
            icon: Icon(Icons.delete, size: 30, color: AppColors.blue),
          ),
          IconButton(
            onPressed: _edit,
            icon: Icon(
              Icons.edit,
              size: 30,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
