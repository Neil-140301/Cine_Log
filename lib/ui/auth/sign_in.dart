import 'package:cine_log/ui/app_controller.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            child: SvgPicture.asset(
              "assets/welcome.svg",
              width: 180,
              height: 180,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Get.toNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    Get.snackbar("Email",
                        "Please check your email to verify your email address");
                  }

                  Get.find<AppController>().setUser(user.email ?? 'John');
                }
              })),
            ],
          ),
        ),
      ],
    );
  }
}
