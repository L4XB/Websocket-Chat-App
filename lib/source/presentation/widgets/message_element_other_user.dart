import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;

  static final userColors = <String, Color>{};

  const MessageBubble({
    super.key,
    required this.message,
    required this.userName,
  });

  Color? getUserColor(String userName) {
    if (!userColors.containsKey(userName)) {
      userColors[userName] =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
    }
    return userColors[userName];
  }

  @override
  Widget build(BuildContext context) {
    final userColor = getUserColor(userName);

    return Align(
      alignment: Alignment.centerLeft,
      child: CustomPaint(
        painter: MessageBubblePainter(color: userColor as Color),
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 15),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubblePainter extends CustomPainter {
  final Color color;

  MessageBubblePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(10, size.height - 10)
      ..lineTo(0, size.height)
      ..lineTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
