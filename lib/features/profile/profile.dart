import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mind_guard/data/repositories/authentication/authentication_repository.dart';
import 'package:mind_guard/features/profile/controller/profile_controller.dart';
import 'package:mind_guard/features/profile/widgets/profile_menu.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/images/circular_image.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Profile"),
      ),
      body: StreamBuilder(
          stream: controller.streamUserDetails(),
          builder: (context, data) {
            final user = data.data;
            if (user != null && data.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      //Profile Picture
                      const SizedBox(
                        width: double.infinity,
                        child: CircularImage(
                          imageUrl: TImages.user,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),

                      //Profile Information
                      const Divider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const SectionHeading(
                        title: "Profile Information",
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      ProfileMenu(
                        title: "Name",
                        value: "${user.fullName.capitalize}",
                        onPressed: () {},
                      ),
                      ProfileMenu(
                        title: "Username",
                        value: user.userName,
                        onPressed: () {},
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      //Personal Information
                      const SectionHeading(
                        title: "Personal Information",
                        showActionButton: false,
                      ),
                      ProfileMenu(
                        title: "User id",
                        value: user.id,
                        icon: Iconsax.copy,
                        onPressed: () {},
                      ),
                      ProfileMenu(
                        title: "Email",
                        value: user.email,
                        onPressed: () {},
                      ),
                      ProfileMenu(
                        title: "Phone Number",
                        value: "+91 ${user.phoneNumber}",
                        onPressed: () {},
                      ),
                      const Divider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide.none,
                            ),
                            onPressed: () =>
                                AuthenticationRepository.instance.logout(),
                            child: const Text("Logout")),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Data Not Found"),
              );
            }
          }),
    );
  }
}
