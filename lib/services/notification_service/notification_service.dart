import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media_app/services/push_notification_service/push_notification_service.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle the notification view while app on kill or background mode
  }

  static Future<void> initializeNotification() async {
    await _firebaseMessaging.requestPermission(announcement: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // handle notification tap route (Background)
    });
    await _getFcmToken();
    await _initializeLocalNotification();
    await _getInitialNotification();
  }

  static Future<String> _getFcmToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
      if (kDebugMode) {
        print('IOS Token ⇒ : $token');
      }
    }
    if (Platform.isAndroid) {
      token = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print('Android Token ⇒ : $token');
      }
    }
    return token!;
  }

  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotificationDetails android =
        AndroidNotificationDetails('CHANNEL ID', 'CHANNEL NAME', priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails? iOS = DarwinNotificationDetails(presentSound: true, presentBanner: true, presentBadge: true, presentAlert: true);
    NotificationDetails notificationDetails = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification?.title,
      notification?.body,
      notificationDetails,
    );
  }

  static Future<void> _getInitialNotification() async {
    await FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      // handle notification tap route (Kill mode)
    });
  }

  static Future<void> _initializeLocalNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
// handle notification tap route (Foreground)
      },
    );
  }

  static Future<void> sendNotification(String title, String body) async {
    String deviceToken = await _getFcmToken();
    PushNotificationService.sendNotificationToSelectedDriver(deviceToken, title, body);
    // String accessToken = '';
    // var messagePayload = {
    //   'message': {
    //     'topic': 'all_devices',
    //     'notification': {
    //       'title': title,
    //       'body': body,
    //     },
    //     'data': {'type': 'chat'},
    //     'android': {
    //       'priority': 'high',
    //       'notification': {'channel_id': 'high_importance_channel'},
    //     }
    //   }
    // };
    // final url =
  }
}
