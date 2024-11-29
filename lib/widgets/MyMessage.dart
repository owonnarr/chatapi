import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMessageWidget extends StatelessWidget {
  final String message;
  final int time;
  final bool isSender;

  MyMessageWidget({
    required this.message,
    required this.time,
    this.isSender = false,
  });

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    var formattedDateTime = DateFormat('HH:mm dd.MM.yy').format(dateTime);

    return Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: isSender
                ? const Color.fromRGBO(88, 124, 149, 1)
                : const Color.fromRGBO(31, 46, 65, 1),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12.0),
              topRight: const Radius.circular(12.0),
              bottomLeft: isSender
                  ? const Radius.circular(12.0)
                  : const Radius.circular(0),
              bottomRight: isSender
                  ? const Radius.circular(0)
                  : const Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(message,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 5.0),
              Text(
                formattedDateTime,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
        ));
  }
}
