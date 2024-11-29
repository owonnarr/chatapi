import 'package:flutter/material.dart';
import 'package:chatios/providers/ProviderChat.dart';
import 'package:chatios/widgets/MyMessage.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessagesListWidget extends StatelessWidget {
  var login;

  MessagesListWidget({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, value, child) {
      return Expanded(
          child: ListView(children: _prepareMessages(value.messages)));
    });
  }

  List<Widget> _prepareMessages(List<Map<String, dynamic>> messages) {
    List<Widget> widgets = [];
    messages.forEach((element) {
      widgets.add(Consumer<MainProvider>(builder: (context, value, child) {
        return MyMessageWidget(
            message: element['text'],
            time: element['timestamp'],
            isSender: element['login'] == login);
      }));
    });
    return widgets;
  }
}
