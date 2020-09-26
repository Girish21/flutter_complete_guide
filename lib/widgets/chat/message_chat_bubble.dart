import 'package:flutter/material.dart';

class MessageChatBubble extends StatelessWidget {
  final String message;
  final String userName;
  final bool isMe;
  final String imageUrl;

  const MessageChatBubble({
    Key key,
    this.message,
    this.isMe,
    this.userName,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft:
                      !isMe ? Radius.circular(0) : Radius.circular(12.0),
                  bottomRight:
                      isMe ? Radius.circular(0) : Radius.circular(12.0),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline6.color,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline6.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: isMe ? 0 : null,
          left: !isMe ? 120 : null,
          top: -10,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
