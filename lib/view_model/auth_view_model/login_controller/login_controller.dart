import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/data/app_preference/app_preference.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/res/components/network_checker/internet_checker.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/services/analytics_service/analytics_service.dart';

class LoginController extends GetxController {
  final _analyticsService = AnalyticsService();
  RxBool passwordVisible = false.obs;
  final internetChecker = Get.put(InternetChecker());
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isAuthenticating = false.obs;
  ValueNotifier userCredential = ValueNotifier('');

  final lFormKey = GlobalKey<FormState>();

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      AppPreference.setPreference('user_preference_key'.tr, true);

      userCredential.value =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.value != null) {
        await databaseRef
            .child(userCredential.value.user!.uid)
            .set(<String, dynamic>{
          'username_key'.tr: '',
          'email_key'.tr: userCredential.value.user!.email,
          'dob_key'.tr: '',
          'gender_key'.tr: '',
          'contact_key'.tr: '',
          'location_key'.tr: '',
          'followers_key'.tr: 0,
          'followings_key'.tr: 0,
          'bio_key'.tr: '',
          'prof_img_key'.tr: '',
        });

        if (kDebugMode) {
          print(userCredential.value.user!.email);
        }
        Get.toNamed(RouteNames.navMenu);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('exception->$e');
      }
    }
  }

  Future<dynamic> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
            '${loginResult.accessToken?.tokenString}');

    if (loginResult.status == LoginStatus.success) {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      if (userCredential.value != null) {
        AppPreference.setPreference('user_preference_key'.tr, true);

        await databaseRef
            .child(userCredentials.user!.uid)
            .set(<String, dynamic>{
          'username_key'.tr: userCredentials.user!.displayName ?? '',
          'email_key'.tr: '',
          'dob_key'.tr: '',
          'gender_key'.tr: '',
          'contact_key'.tr: '',
          'location_key'.tr: '',
          'followers_key'.tr: 0,
          'followings_key'.tr: 0,
          'bio_key'.tr: '',
          'prof_img_key'.tr: '',
        });
        Get.offNamed(RouteNames.navMenu);
      }
    }
  }

  Future<void> submit() async {
     try {
      _analyticsService.sendAnalyticsEvent();
      if (internetChecker.isInternetConnected) {
        if (lFormKey.currentState!.validate()) {
          lFormKey.currentState!.save();
          await firebase.signInWithEmailAndPassword(
              email: email.value, password: password.value);
          AppPreference.setPreference('user_preference_key'.tr, true);
          _analyticsService.logSignInWithEmailPassword(email: email.value);
          Get.offNamed(RouteNames.navMenu);
          isAuthenticating.value = false;
        } else {
          isAuthenticating.value = false;
        }
      } else {
        Get.snackbar("Internet Error", "Please Check Your Internet Connection");
        isAuthenticating.value = false;
      }
    } on FirebaseAuthException catch (error) {
      isAuthenticating.value = false;
      if (error.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        isAuthenticating.value = false;
        Get.snackbar("Email or Password is Incorrect",
            'If you not have an account , signup first');
      } else if (error.message == 'The email address is badly formatted.') {
        isAuthenticating.value = false;
        Get.snackbar("Enter proper email", '${error.message}');
      } else {
        isAuthenticating.value = false;
        Get.snackbar(
            "Authentication Exception", error.message ?? 'auth_failed'.tr);
      }
    }
  }
}
