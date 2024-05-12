import 'package:get/get.dart';
import 'package:mind_guard/data/repositories/alzhiemer/alzhiemer_repository.dart';
import 'package:mind_guard/data/repositories/brain_tumour/brain_tumour_repository.dart';
import 'package:mind_guard/data/repositories/depression/depression_repository.dart';
import 'package:mind_guard/data/repositories/patient_details/patient_details_repository.dart';
import 'package:mind_guard/data/repositories/user/user_repository.dart';

import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AlzheimerRepository());
    Get.put(UserRepository());
    Get.put(BTRepository());
    Get.put(DepressionRepository());
    Get.put(PatientDetailsRepository());
  }
}
