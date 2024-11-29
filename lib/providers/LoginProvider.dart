import 'package:flutter/material.dart';
import 'package:chatios/api/LoginApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  LoginApi api = LoginApi();
  String? _login;
  String? _avatar;
  int _counter = 0;

  String get login => _login ?? '';
  String get avatar =>
      _avatar ??
      'https://ia600305.us.archive.org/31/items/discordprofilepictures/discordblue.png';

  bool get isLoggedIn => _login != null;

  Future<bool> auth(login, password, rememberMe) async {
    Map result = await api.checkAuthorization(login, password);
    if (result['status']) {
      _login = login;
      _avatar = result['data']['avatar'];
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('login', login);
        await prefs.setString('avatar', result['data']['avatar'] as String);
        await prefs.setInt('counter', 5);
      }
    }
    notifyListeners();
    return result['status'];
  }

  Future<void> autoAuth() async {
    final sharedStorage = await SharedPreferences.getInstance();
    _login = sharedStorage.getString('login');
    _avatar = sharedStorage.getString('avatar');
    _counter = sharedStorage.getInt('counter') ?? 0;

    if (_counter > 0) {
      _counter--;
      await sharedStorage.setInt('counter', _counter);
    } else {
      await sharedStorage.clear();
      _login = null;
    }

    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _login = null;
    notifyListeners();
  }
}
