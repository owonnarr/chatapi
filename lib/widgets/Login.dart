import 'package:flutter/material.dart';
import 'package:chatios/providers/LoginProvider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidget createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    await loginProvider.autoAuth();

    if (loginProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/chat');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Помилка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрити'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(107, 180, 107, 1.0),
          title:
              const Text('Авторизація', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<LoginProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: loginController,
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Логін',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Пароль',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                      activeColor: Colors.greenAccent,
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'Запам\'ятати мене',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    final login = loginController.text.trim();
                    final password = passwordController.text.trim();

                    if (login.isEmpty || password.isEmpty) {
                      _showError('Будь ласка, введіть логін і пароль');
                    } else {
                      var validationResult = await Provider.of<LoginProvider>(
                              context,
                              listen: false)
                          .auth(login, password, rememberMe);
                      if (validationResult) {
                        Navigator.pushReplacementNamed(context, '/chat');
                      } else {
                        _showError(
                            'Невірні авторизаційні дані, або користувач не зареєстрований в системі');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
                  ),
                  child: const Text(
                    'Авторизуватися',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
