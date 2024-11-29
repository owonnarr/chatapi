import 'package:firebase_database/firebase_database.dart';

class LoginApi {
  final DatabaseReference _db = FirebaseDatabase.instance.ref('users');

  Future<Map> checkAuthorization(login, password) async {
    Map validationResults = {};
    final query = _db.child(login);
    final snapshot = await query.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      if (data['password'] == password) {
        validationResults['status'] = true;
        validationResults['data'] = data;
      } else {
        validationResults['status'] = false;
      }
    } else {
      validationResults['status'] = false;
    }
    return validationResults;
  }
}
