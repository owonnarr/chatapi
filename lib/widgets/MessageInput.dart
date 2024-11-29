import 'package:flutter/material.dart';
import '../states/MessageInputState.dart';

// ignore: must_be_immutable
class MessageInputWidget extends StatefulWidget {
  var login;

  MessageInputWidget({super.key, required this.login});

  @override
  State<MessageInputWidget> createState() => MessageInputState();
}