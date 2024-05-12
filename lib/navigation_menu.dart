import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mind_guard/features/alzhiemer/screen/patient_details.dart';
import 'package:mind_guard/features/depression/screen/depression_patient_details.dart';
import 'package:mind_guard/features/history/screen/history.dart';
import 'package:mind_guard/utils/constants/colors.dart';
import 'package:mind_guard/utils/helpers/helper_functions.dart';

import 'features/profile/profile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.brain), label: "Alzheimer"),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.kitMedical), label: "BT"),
            NavigationDestination(
                icon: FaIcon(Icons.sentiment_very_dissatisfied),
                label: "Depression"),
            NavigationDestination(icon: Icon(Icons.history), label: "History"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
          backgroundColor: isDarkMode ? TColors.black : Colors.white,
          indicatorColor: isDarkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const PatientDetailScreen(),
    const PatientDetailScreen(),
    const DepressionPatientDetailsScreen(),
    HistoryScreen(),
    const ProfileScreen(),
  ];
}
