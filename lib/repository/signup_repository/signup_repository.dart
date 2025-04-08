import 'package:social_media_app/data/network/dio_network_api_services.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/res/app_url/app_url.dart';

class SignUpRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> signupApi(var data) async {
    dynamic response = _apiServices.postApi(
        data, '${AppUrl.baseAPI}/users-list/123456.json');
    return response;
  }
}
