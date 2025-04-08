import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : {
      'app_name': 'Social Media', // Splash Screen App Name

      'email': 'Email',
      'cancel': 'Cancel',
      'login': 'Login',
      'signup': 'Sign up',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password',
      'send_verification_link': 'Send Verification Email',
      'send_reset_email': 'Send Reset Email',
      'verify_email': 'Verify Email',
      'home_page': 'Home',
      'create_account': 'Don\'t have an account? Create Account',
      'login_account': 'Already have an account? Login',
      'reset_password': 'Reset Password',
      'dob': 'Date of Birth',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'contact_no': 'Contact No',
      'last_name': 'Last Name',
      'first_name': 'First Name',
      'user_id': 'User ID',
      'user_name': 'User Name',

      //Images Path and Images name
      'image_path': 'assets/images/',
      'splash_image': 'splash.png',
      'prof_place': 'profile_place_1.webp',
      'prof1': 'prof1.jpeg',
      'prof2': 'prof2.jpeg',
      'prof3': 'prof3.jpeg',
      'prof4': 'prof4.jpeg',
      'prof5': 'prof5.jpeg',
      'prof6': 'prof6.jpeg',
      'p1': 'p1.jpeg',
      'p2': 'p2.jpeg',
      'p3': 'p3.jpeg',
      'p4': 'p4.jpeg',
      'p5': 'p5.jpeg',
      'p6': 'p6.jpeg',
      'p7': 'p7.jpeg',

      'icon_path': 'assets/icons/',
      'add': 'add_icon.png',
      'tel': 'telegram_plane.png',
      'comment': 'comment.png',
      'share': 'share_post.png',
      'google': 'google.png',
      'facebook': 'facebook.png',
      'apple': 'apple.png',
      "cancel_icon": "cancel.png",

      // Shared Preference Key use to store login user email
      'user_preference_key': 'user',

      //Messages used in controllers
      'missing_email': 'Please enter your email address',
      'auth_failed': 'Authentication failed.',
      'required_fields': 'Please enter email and password',
      'email_verified': 'Email Already Verified...',
      'password_not_match': 'Please check password and confirm password',

      // Collection Name and doc fields list
      'collection_name': 'users',

      'firstname_key': 'firstname',
      'lastname_key': 'lastname',

      'userid_key': 'userid',
      'username_key': 'username',
      'email_key': 'email',
      'dob_key': 'dob',
      'gender_key': 'gender',
      'contact_key': 'contact',
      'password_key': 'password',
      'location_key': 'location',
      'followers_key': 'followers',
      'followings_key': 'followings',
      'bio_key': 'bio',
      'prof_img_key': 'profile',
    },
  };
}
