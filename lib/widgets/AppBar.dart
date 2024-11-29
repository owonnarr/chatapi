import 'package:flutter/material.dart';
import 'package:chatios/providers/LoginProvider.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, value, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 30, backgroundImage: NetworkImage(value.avatar)),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    value.login,
                    style: const TextStyle(color: Colors.white),
                  ))
            ],
          ),
          InkWell(
              onTap: () {
                Provider.of<LoginProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Icon(Icons.logout, color: Colors.white))
        ],
      );
    });
  }
}
