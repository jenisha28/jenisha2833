import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view_model/user_view_model/alert_controller/alert_controller.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final alerts = Get.put(AlertController());

  @override
  void initState() {
    // TODO: implement initState
    alerts.sortAlerts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts"),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Mark all as read",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.blue, fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var alert in alerts.sortedAlerts)
                if (alerts.alertTime(alert.timestamp) < 24)
                  Card(
                    color:
                        Get.isDarkMode ? AppColors.blueGrey : AppColors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(alert.imageUrl),
                      ),
                      title: Text(
                        alert.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                          '${alert.message}\n${alerts.postTime(alert.timestamp)}'),
                      isThreeLine: true,
                    ),
                  ),
              Text(
                "This Week",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.grey,
                    ),
              ),
              for (var alert in alerts.sortedAlerts)
                if (alerts.alertTime(alert.timestamp) > 24)
                  Column(
                    children: [
                      Card(
                        color: Get.isDarkMode
                            ? AppColors.blueGrey
                            : AppColors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage: NetworkImage(alert.imageUrl),
                          ),
                          title: Text(
                            alert.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: alert.isRead
                                        ? FontWeight.w400
                                        : FontWeight.w600),
                          ),
                          subtitle: Text(
                              '${alert.message}\n${alerts.postTime(alert.timestamp)}'),
                          isThreeLine: true,
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
