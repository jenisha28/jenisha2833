

import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/users_model/users_model.dart';

class UserRepository {
  static List<UsersModel> getUsers() {
    List<UsersModel> users = DummyData.usersDetails;
    return users;
  }
}