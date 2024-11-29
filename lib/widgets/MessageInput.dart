import 'package:flutter/material.dart';
import 'package:chatios/providers/ProviderChat.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessageInputWidget extends StatefulWidget {
  var login;

  MessageInputWidget({super.key, required this.login});

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  String _message = '';
  final messageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            // color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(25.0)),
        child: Row(children: [
          Expanded(
              child: TextField(
            onChanged: (value) {
              _message = value;
            },
            onSubmitted: (String value) {
              if (_message.isNotEmpty) {
                Provider.of<MainProvider>(context, listen: false)
                    .sendMessage(_message, widget.login);
                _message = '';
                messageInputController.clear();
              }
            },
            controller: messageInputController,
            cursorColor: Colors.green,
            decoration: const InputDecoration(
                hintText: "Введіть повідомлення",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          )),
          InkWell(
            onTap: () {
              if (_message.isNotEmpty) {
                Provider.of<MainProvider>(context, listen: false)
                    .sendMessage(_message, widget.login);
                _message = '';
                messageInputController.clear();
              }
            },
            child: const Icon(Icons.send, color: Colors.green),
          )
        ]));
  }
}
