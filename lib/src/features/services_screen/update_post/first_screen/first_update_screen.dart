import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/Constants/colors.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import '../../../../utils/widgets/shimmer_effect.dart';
import 'controller/controller.dart';

class FirstUpdateServicesForm extends StatelessWidget {
  FirstUpdateServicesForm({super.key});

  final controller = Get.put(FirstUpdateServicesFormController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - FirstUpdateServicesForm............");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 64, top: 13),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.nameController,
                  labelText: 'Name',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: controller.descriptionController,
                  minLines: 1,
                  maxLines: 10,
                  maxLength: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Description (Optional)",
                    prefixIcon: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    suffixStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                ),

                const SizedBox(height: 16),
                //==========House Address================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.addressController,
                  labelText: 'Enter Address',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                //===========City Name================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.landmarkController,
                  labelText: 'Enter landmark',
                  icon: const Icon(Icons.location_on, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //============Land Mark address=================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.cityController,
                  labelText: 'Enter City',
                  icon: const Icon(Icons.location_city_outlined,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.stateController,
                  labelText: 'Enter State',
                  icon: const Icon(Icons.map, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                // 2. Select images
                InkWell(
                  onTap: controller.pickImages,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Choose Images",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => (controller.imageFiles.isNotEmpty)
                      ? Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 150, // Explicit height constraint
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageFiles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(controller.imageFiles[index].path),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 16),
                          // Added Container to ensure constraints
                          height: 150,
                          // Explicit height for the ListView
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.servicesData.image?.length ?? 0,
                            itemBuilder: (context, imageIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    width: Get.width * 0.8,
                                    imageUrl: controller
                                            .servicesData.image?[imageIndex] ??
                                        '',
                                    placeholder: (context, url) =>
                                        ShimmerEffect(
                                            width: Get.width * 0.8,
                                            height: 140),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.image_outlined),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),

                    const FormHeadline(title: 'FAQ'),
                    const SizedBox(
                      height: 5,
                    ),

                    Obx(
                          () => controller.servicesFAQ.isEmpty
                          ? const Center(child: Text(''))
                          : Column(
                        children:
                        controller.servicesFAQ.asMap().entries.map((entry) {
                          int index = entry.key;

                          return ListTile(
                            title: Text(
                              'Q${index + 1} :-  ${controller.servicesFAQ[index].question}',
                            ),
                            subtitle: Text(
                              'Answer :-  ${controller.servicesFAQ[index].answer}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => controller.removeServicesFAQ(index),
                            ),
                          );

                        }).toList(),
                      ),
                    ),

                    Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: controller.showAddServicesFAQDialog,
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            size: 40,
                          ),
                        )),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                const SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () => controller.onSaveAndNext(),
                  title: "Save",
                ),
                const SizedBox(height: 20),
                ReuseElevButton(
                  color: Colors.orange,
                  onPressed: () => Get.back(),
                  title: "Back",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
