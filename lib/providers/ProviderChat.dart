import 'package:flutter/material.dart';
import 'package:chatios/api/ChatApi.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];
  List<Map<String, dynamic>> get messages => _messages;

  Api api = Api();

  MainProvider() {
    _listenToMessages();
  }

  void _listenToMessages() {
    api.listenToChat((messages) {
      _messages = messages;
      notifyListeners();
    });
  }

  void sendMessage(String message, login) {
    final newMessage = {
      "text": message,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "login": login
    };
    api.sendMessage(newMessage);
  }
}
