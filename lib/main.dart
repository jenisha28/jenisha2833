import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/app_preference/app_preference.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/my_app.dart';
import 'package:social_media_app/services/notification_service/notification_service.dart';

final firebase = FirebaseAuth.instance;
final databaseRef = FirebaseDatabase.instance.ref('users-list');
final databaseRefPost = FirebaseDatabase.instance.ref('posts-list');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  NotificationService.initializeNotification();
  FirebaseMessaging.onBackgroundMessage(NotificationService.firebaseMessagingBackgroundHandler);
  await AppPreference.sharedInstance();
  runApp(const MyApp());
}

