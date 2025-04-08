
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/alert_model/alert_model.dart';

class AlertRepository {
  static List<Alert> getAlerts() {
    List<Alert> alert = DummyData.alertsDetails;
    return alert;
  }
}