import 'package:get/get.dart';
import 'package:social_media_app/model/alert_model/alert_model.dart';
import 'package:social_media_app/repository/alert_repository/alert_repository.dart';

class AlertController extends GetxController {
  final alerts = AlertRepository.getAlerts();
  List sortedAlerts = <Alert>[].obs;

  final currTime = DateTime.now();
  String postTime(String pTime) {
    DateTime t = DateTime.parse(pTime);
    Duration timeData = currTime.difference(t);
    if (timeData.inSeconds < 60) {
      return "${timeData.inSeconds} seconds ago";
    } else if (timeData.inMinutes < 60) {
      return "${timeData.inMinutes} minutes ago";
    } else if (timeData.inHours < 24) {
      return "${timeData.inHours} hours ago";
    } else if (timeData.inDays < 30) {
      return "${timeData.inDays} day ago";
    } else if (timeData.inDays < 365) {
      return "${(timeData.inDays / 31).toString().split('.')[0]} month ago";
    } else {
      return "${(timeData.inDays / 365).toString().split('.')[0]} year ago";
    }
  }

  int alertTime(String pTime) {
    DateTime t = DateTime.parse(pTime);
    Duration timeData = currTime.difference(t);

    return timeData.inHours;
  }

  void sortAlerts() {
    sortedAlerts = alerts.map((cmt) => cmt).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
}
