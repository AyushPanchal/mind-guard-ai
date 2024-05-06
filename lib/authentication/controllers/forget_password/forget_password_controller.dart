import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //Send reset password email
  sendPasswordResetEmail() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.doccerAnimation);

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
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Send Email to reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success screen
      TLoaders.succcesSnackBar(
          title: "Email Sent",
          message: "Email Link is sent to reset your password".tr);

      //Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      try {
        //Loading
        TFullScreenLoader.openLoadingDialog(
            "Logging you in...", TImages.doccerAnimation);

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

        //Send Email to reset Password
        await AuthenticationRepository.instance.sendPasswordResetEmail(email);

        //Remove Loader
        TFullScreenLoader.stopLoading();

        //Show success screen
        TLoaders.succcesSnackBar(
            title: "Email Sent",
            message: "Email Link is sent to reset your password".tr);
      } catch (e) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        //Show error message
        TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      }
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
