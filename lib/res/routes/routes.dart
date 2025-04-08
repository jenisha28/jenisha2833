
import 'package:get/get.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view/auth/email_signup/email_signup.dart';
import 'package:social_media_app/view/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:social_media_app/view/auth/forgot_password_screen/fp_screen.dart';
import 'package:social_media_app/view/auth/login_screen/login_screen.dart';
import 'package:social_media_app/view/auth/otp_verification_screen/email_otp_verification.dart';
import 'package:social_media_app/view/auth/otp_verification_screen/otp_verification_screen.dart';
import 'package:social_media_app/view/auth/reset_password_screen/reset_password_screen.dart';
import 'package:social_media_app/view/auth/signup_screen/signup_screen.dart';
import 'package:social_media_app/view/auth/splash_screen/splash_screen.dart';
import 'package:social_media_app/view/user_view/add_post_screen/add_post_screen.dart';
import 'package:social_media_app/view/user_view/chat_screen/send_image.dart';
import 'package:social_media_app/view/user_view/alerts_screen/alerts_screen.dart';
import 'package:social_media_app/view/user_view/chat_list/chat_list.dart';
import 'package:social_media_app/view/user_view/chat_screen/chat_screen.dart';
import 'package:social_media_app/view/user_view/dashboard/story_view.dart';
import 'package:social_media_app/view/user_view/dashboard/users_profile.dart';
import 'package:social_media_app/view/user_view/nav_menu/nav_menu.dart';
import 'package:social_media_app/view/user_view/post_details/post_details.dart';
import 'package:social_media_app/view/user_view/profile/edit_profile.dart';
import 'package:social_media_app/view/user_view/profile/followers.dart';
import 'package:social_media_app/view/user_view/profile/followings.dart';
import 'package:social_media_app/view/user_view/profile/profile_screen.dart';

class Routes {
  static appRoutes () => [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteNames.signupScreen,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: RouteNames.emailSignup,
      page: () => EmailSignup(),
    ),
    GetPage(
      name: RouteNames.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteNames.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: RouteNames.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: RouteNames.otpVerificationScreen,
      page: () => OtpVerificationScreen(),
    ),
    GetPage(
      name: RouteNames.emailVerificationScreen,
      page: () => EmailOtpVerification(),
    ),
    GetPage(
      name: RouteNames.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => EditProfile(),
    ),
    GetPage(
      name: RouteNames.navMenu,
      page: () => NavMenu(),
    ),
    GetPage(
      name: RouteNames.addPostScreen,
      page: () => AddPostScreen(),
    ),
    GetPage(
      name: RouteNames.storyScreen,
      page: () => Story(),
    ),
    GetPage(
      name: RouteNames.postDetailsScreen,
      page: () => PostDetails(),
    ),
    GetPage(
      name: RouteNames.usersProfile,
      page: () => UsersProfile(),
      // transition: Transition.downToUp,
      // transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteNames.alertsScreen,
      page: () => AlertsScreen(),
    ),
    GetPage(
      name: RouteNames.chatScreen,
      page: () => ChatScreen(),
    ),
    GetPage(
      name: RouteNames.chatList,
      page: () => ChatList(),
    ),
    GetPage(
      name: RouteNames.sendImage,
      page: () => SendImage(),
    ),
    GetPage(
      name: RouteNames.followers,
      page: () => Followers(),
    ),
    GetPage(
      name: RouteNames.followings,
      page: () => Followings(),
    ),
    GetPage(
      name: RouteNames.fpScreen,
      page: () => FpOtpScreen(),
    ),
  ];
}