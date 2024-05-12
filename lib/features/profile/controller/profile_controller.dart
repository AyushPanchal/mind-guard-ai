import 'package:get/get.dart';
import 'package:mind_guard/data/repositories/user/user_repository.dart';

import '../../authentication/models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _userRepository = UserRepository.instance;

  Stream<UserModel> streamUserDetails() {
    return _userRepository.streamUserDetails();
  }
}
