class UserModel {
  UserModel._privateConstructor();

  static final UserModel _instance = UserModel._privateConstructor();

  factory UserModel() {
    return _instance;
  }

  String userName = "App User";
}
