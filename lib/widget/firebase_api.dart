
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print("Title is: ${message.notification?.title}");
    print("Title is: ${message.notification?.body}");
    print("Title is: ${message.data}");
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications () async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print("Token $fcmToken");
    }
    FirebaseMessaging.onBackgroundMessage((message) => handleBackgroundMessage(message));
  }
 }