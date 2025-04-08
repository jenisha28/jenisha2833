
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/components/network_checker/internet_checker.dart';

class InternetCheckScreen extends StatefulWidget {
  const InternetCheckScreen({super.key});

  @override
  State<InternetCheckScreen> createState() => _InternetCheckScreenState();
}

class _InternetCheckScreenState extends State<InternetCheckScreen>
    with TickerProviderStateMixin {

  final internetController = Get.put(InternetChecker());

  @override
  void initState() {
    super.initState();
    internetController.checkConnection();
  }

  @override
  void dispose() {
    internetController.subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          size: 50,
          color: Colors.red,
        ),
        SizedBox(height: 20),
        Text(
          "No internet connection",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
