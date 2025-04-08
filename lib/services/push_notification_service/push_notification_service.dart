import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "social-media-725a0",
      "private_key_id": "ed5424210cd3225893682056a437b22a896490fa",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCL5LO6I/32aS57\nBGtQ91dRX+8fuFa1GeA3BUeIbgJ8QXGVrwTYiYMT036VsVJOeZ0RTbzCvcgsxLnS\n5rM03k4LJrpYhiIb+23io8Vkz+bIP44yLfK35DcZV/SG66DMtt3MTAMwedzzFlnc\njNpcRwVy6tCIjCszlcqT7O0nOpe+yYJ1r8Lg2ozKVTYa8caouTd0Dz0Jv53T/wK3\nE0mvEjsdcf5gekM47ZFWUsv9CmLvaqjOK+zaIagpVgBzSxmFRucFshDMBRlYF++F\nqzHk56ZeWyGWCM4evRdinSqTqWzcd+Eb2X7HS+b23oobFdGGcFy1QJ3m4zikA2UW\nF3Kt5RdXAgMBAAECggEADoKtSSL/mOYbGKPXioFFZjRDEPFlfl54koHH2Ypo/pYp\nNSNU0i3H/K/6LYZu6PiWBrFKDDx0PX81s9RohT+D19tEsUxPJcOO3SyAm+7cBixg\nJatSGv9J3yVE62kYd54w48aEqYFnyN0qJVraMX/PvGDykB9TQdlejGPNy5JjzWRh\nNG/StcS8ELXk29DboPhr2qflQ7T3opArBqWZqCpNo7tNp6Xng6SAZhV56f04kciu\npJzhV0Ng5MUbthF+neZXlJY/NbCMnm74Rc2UZq2pW5JcjNNmPbdPOqhre56wdDCB\nuOSdivHXECXERB7h3VbJRWhcQTOUmzwmKZueG6/1gQKBgQDFs/FV+On6CzL872FF\nB/9hVdtkz3M00/dHffeccuWDmeZidxktyMKFk1K+Qx5t9QWoLwQ9XCjFeLAlmSRa\nG9NUP+Pnk9y8zKnHeHd7rz6VGKrt/ku4BeBEoq9BUS3OJ/yX8U0biliYcRV2yOIw\nDqZr5vm0IX2KrA5N9mQqbRWz1wKBgQC1JN+963ToOnzKbp1TODHudJOjxWViUh2T\nlm3Eri0p3tuwYy9q+pvIdjY566OeMurm5unZ4NNDtOwO8MbV7gNMxGSxIh+mkG3p\nAZ1mhqACVOTwPriFUZzmKG14OxbFwXgbYGaS9/t1qdNHLo7d28L9CAjmwyZuoHDP\nevgTw4dIgQKBgEAiW4vUL7LZpzS+QwOt0H6253EQiwL8MB+VEZpC+4lxh3cxw41C\nrze9zv3BsEFjVu50Mh/loaRNvnaz80L3+9o8z6X0JYtpqTn4LmqFMvwTAIAsGkwc\nO+CIFepOd1mFRz/TG3xvqMXrCVd7W0TTu9ENILv6kUtG/Wz1HRFWSdAJAoGBAJWT\nkT1eA/cO9KSjmj1xlal1kcQV55W8gLex64oQ2TJN19Ja1Hjd3200T6qcLUsgeF+a\nJVfIEitCZfogT8+u7gKh2RN7Pe9oK5nPv409dTr3puPKpstPjONwVpSFFlTNYMQa\nYhjRtE6AoPmSNF52bRhLXi5Ozpli2kQ5IkgPmNIBAoGAFtOaPUsySkbT/Fn+BEHU\nMxXMEh/wESgj4IbZw/NIyY+h/qG71A9/6zWM1SjIpPv+k66XAQIqm1+XDPgJLl8d\ngoeShrweidQCz4RL8Nuc3BsBPDr6AeuT1HKaip8FFZEbSpv+W70zXc3/Gg8XVZFH\niXYhmGG8q1sH6KdTnU19/fI=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "social-media-app@social-media-725a0.iam.gserviceaccount.com",
      "client_id": "100785691178774037320",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/social-media-app%40social-media-725a0.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      // 'https://www.googleapis.com/auth/userinfo.email',
      // 'https://www.googleapis.com/auth/database',
      'https://www.googleapis.com/auth/messaging'
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(
      String deviceToken, String title, String body) async {
    final String serverAccessTokenKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/social-media-725a0/messages:send';
    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          // 'title': 'Harry Potter',
          // 'body': 'Hello, Voldemort',
          'title': title,
          'body': body,
        },
        // 'data': {
        //   'tripId': tripId,
        // }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification Send Successfully');
    } else {
      print('Failed to sent FCM Message , ${response.statusCode}');
    }
  }
}
