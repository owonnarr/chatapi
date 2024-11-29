import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/LoginProvider.dart';
import '../widgets/AppBar.dart';
import '../widgets/MessageInput.dart';
import '../widgets/MessageList.dart';

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(118, 187, 208, 1.0),
          title: const AppBarWidget(),
          toolbarHeight: 80,
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://framerusercontent.com/images/FIIavQvTDyzZOSh1oe09QxMS6QQ.jpg'),
                    fit: BoxFit.cover)),
            child: SafeArea(child: _Content())));
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, value, child) {
      var login = value.login;
      return Column(
        children: [
          const SizedBox(height: 10),
          MessagesListWidget(login: login),
          MessageInputWidget(login: login)
        ],
      );
    });
  }
}