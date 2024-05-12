import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/common/widgets/appbar/appbar.dart';
import 'package:mind_guard/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mind_guard/features/brain_tumour/controller/brain_tumour_controller.dart';
import 'package:mind_guard/features/brain_tumour/screen/brain_tumour_result_screen.dart';
import 'package:mind_guard/utils/constants/sizes.dart';

class BTScreen extends StatelessWidget {
  const BTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BTController());
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Upload Brain MRI"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              Obx(
                () => RoundedContainer(
                  height: 208,
                  width: 208,
                  backgroundColor: Colors.black,
                  showBorder: true,
                  child: controller.imageFile.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            image: FileImage(controller.imageFile.value!),
                          ),
                        )
                      : const Center(child: Text("Please Select an Image")),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Obx(
                () => controller.imageSelected.value
                    ? Container()
                    : Text(
                        "Please select an image to continue",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.red),
                      ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => controller.getImageAndUpload(),
                  child: const Text("Select Image"),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const BTResultScreen()),
                  child: const Text("Make Prediction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
