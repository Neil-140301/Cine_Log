import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScreen(
      email: Get.arguments['email'] ?? '',
      headerMaxExtent: 200,
    );
  }
}
