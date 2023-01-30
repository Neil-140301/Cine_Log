import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final _loggedIn = false.obs;
  bool get loggedIn => _loggedIn.value;

  final _user = "".obs;
  String get user => _user.value;

  final _GOOGLE_CLIENT_ID =
      '712075030687-0d3u4ra0ap92s2e4ef43f67ovdmsi11j.apps.googleusercontent.com';

  @override
  void onInit() async {
    super.onInit();

    FirebaseUIAuth.configureProviders(
        [EmailAuthProvider(), GoogleProvider(clientId: _GOOGLE_CLIENT_ID)]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn.value = true;
      } else {
        _loggedIn.value = false;
      }
    });
  }

  setUser(String user) => _user.value = user;
}
