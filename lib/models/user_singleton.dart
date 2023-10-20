import 'package:spedtracker_app/models/user_model.dart';

class UserSingleton {
  UserSingleton._internal();
  static final UserSingleton _instance = UserSingleton._internal();
  UserModel currentUser = UserModel.empty();

  static UserSingleton get instance {
    return _instance;
  }
}

