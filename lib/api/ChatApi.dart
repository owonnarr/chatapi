import 'package:firebase_database/firebase_database.dart';

class Api {
  final DatabaseReference _db = FirebaseDatabase.instance.ref('messages');

  void listenToChat(Function onMessage) {
    List<Map<String, dynamic>> messages = [];
    _db.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        messages = data.entries
            .map((e) => {"id": e.key, ...Map<String, dynamic>.from(e.value)})
            .toList();
        messages.sort((a, b) {
          if (a['timestamp'] > b['timestamp']) {
            return 1;
          } else if (a['timestamp'] < b['timestamp']) {
            return -1;
          } else {
            return 0;
          }
        });
      }
      onMessage(messages);
    });
  }

  void sendMessage(message) async {
    _db.push().set(message);
  }
}
