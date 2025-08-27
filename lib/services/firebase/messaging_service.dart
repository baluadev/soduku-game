import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.toMap());

  // message.messageType
  // await pushNewMusicNotification(
  //   message.notification?.title ?? '🎧 Muzee',
  //   message.notification?.body ?? '',
  //   message.data,
  // );
}

class MessagingService {
  static final MessagingService inst = MessagingService._internal();
  MessagingService._internal();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final StreamControllerhandleData = StreamController.broadcast();

  Future<void> setup() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
//Listen from firebase
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationData(message);
    });

    // App bị tắt, mở lại từ notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationData(message);
      }
    });
  }

  _handleNotificationData(RemoteMessage message) {
    final data = message.data;
    if (data.containsKey('songId')) {
      // final song = SongModel.fromJson(data);
      // handleData.add(song);
    }
  }

  dispose() {
    // handleData.close();
  }

  Future<String?> getToken() async {
    return await messaging.getToken();
  }
}
