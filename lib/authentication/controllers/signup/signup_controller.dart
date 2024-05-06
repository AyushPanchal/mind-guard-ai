import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../models/user_model.dart';
import '../../screens/signup/verify_email.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  ///variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final firstName = TextEditingController(); //first name controller
  final lastName = TextEditingController(); //last name controller
  final userName = TextEditingController(); //user name controller
  final email = TextEditingController(); //email controller
  final password = TextEditingController(); //password controller
  final phoneNumber = TextEditingController(); //phone number controller
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>(); //signUp form key

  ///Sign up
  //SignUp
  void signup() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          "As we are processing your information...", TImages.doccerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet Connection',
            message:
                "You are not connected to the network. Please get connected to proceed.");
        return;
      }

      //Form Validation
      if (!signUpFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account , you must read and accept the Privacy Policy & Terms of use");
      }

      //Register user in-the Firebase Authentication &save user data in Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //Save Authenticated user data in firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: "");
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show Success Message
      TLoaders.succcesSnackBar(
        title: "Congratulations",
        message: "Your account has been created. Verify mail to continue",
      );

      // Move to Verify Email Screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
