import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../utils/widgets/bottom_chat_and_call_widgets.dart';
import '../../../utils/widgets/faq_widgets.dart';
import '../../../utils/widgets/report_card_widgets.dart';
import '../../../utils/widgets/review_view_card.dart';
import '../../../utils/widgets/submit_review_widgets.dart';
import '../../../utils/widgets/view_map_card_widgets.dart';
import 'controller/details_room_controller.dart';

class DetailsRoom extends StatelessWidget {
  DetailsRoom({super.key});

  final controller = Get.put(DetailsRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          '${controller.data.houseName?.capitalizeFirst}',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: BottomChatAndCallWidgets(
        onTapChat: () {},
        onTapCall: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 400, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.data.imageList!.length,
                      onPageChanged: (int page) {
                        controller.currentPage.value = page;
                      },
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: controller.data.imageList![imageIndex],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${controller.currentPage + 1}/ ${controller.data.imageList!.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueAccent,
                    ),
                    child: const Text(
                      'BOYS',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.amber,
                    ),
                    child: Text(
                      '${controller.data.roomCategory}',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${controller.data.roomType}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 16,
              ),
              ViewMapCardWidgets(controller: controller),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child: Column(
                  children: [
                    if(controller.data.familyCost!.isNotEmpty)
                    CostText(title: 'BHK Cost', cost: controller.data.familyCost.toString(), ),
                    if(controller.data.singlePersonCost!.isNotEmpty)
                    CostText(title: 'Single Person Price', cost: controller.data.singlePersonCost.toString(), ),
                    if(controller.data.doublePersonCost!.isNotEmpty)
                    CostText(title: 'Double Person Price', cost: controller.data.doublePersonCost.toString(), ),
                    if(controller.data.triplePersonCost!.isNotEmpty)
                    CostText(title: 'Triple Person Price', cost: controller.data.triplePersonCost.toString(), ),
                    if(controller.data.triplePlusCost!.isNotEmpty)
                    CostText(title: 'Triple Plus Person Price', cost: controller.data.triplePlusCost.toString(), ),
                    if(controller.data.depositAmount!.isNotEmpty)
                    CostText(title: 'One Time Security Deposit Amount', cost: controller.data.depositAmount.toString(), ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if(controller.data.roomFacilityList!.isNotEmpty)
              const Text(
                'Room Offering',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              if(controller.data.roomFacilityList!.isNotEmpty)
              Card(
                color: Colors.white,
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 10, // space between containers
                      runSpacing: 10, // space between lines
                      children: controller.data.roomFacilityList!
                          .map((item) => Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ))
                          .toList(),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),

              const Text(
                'Other Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room is provided by the ${controller.data.roomOwnershipType}.',
                      ),
                      SizedBox(height: 8), // Space between each text
                      Text(
                        'Total number of room - ${controller.data.totalRoom}',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Room is available - ${controller.data.isRoomAvailableDate}',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Notice period - ${controller.data.noticePride}',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Meals is available - ${controller.data.mealsAvailable}',
                      ),

                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              if(controller.data.commonAreasList!.isNotEmpty)
              const Text(
                'Common area',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: controller.data.commonAreasList!.map((bill) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bill,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              if(controller.data.billsList!.isNotEmpty)
              const Text(
                'Bills',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: controller.data.billsList!.map((bill) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bill,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              if(controller.data.houseRules!.isNotEmpty)
              const Text(
                'House Rules',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                  children: controller.data.houseRules!.map((rule) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.greenAccent,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(rule)
                    ],
                  ),
                );
              }).toList()),
              const SizedBox(
                height: 16,
              ),
              SubmitReviewWidgets(
                onTap: () => AppHelperFunction.showSubmitReviewAndRatingDialog(
                    controller),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RoutesName.viewAllReview),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ReviewViewCardWidgets(
                imageUrl: '',
                userName: 'Reetu',
                date: '12/122022',
                rating: '2.5',
                review: 'This my review',
              ),
              ReviewViewCardWidgets(
                imageUrl: '',
                userName: 'Reetu',
                date: '12/122022',
                rating: '2.5',
                review: 'This my review',
              ),
              ReviewViewCardWidgets(
                imageUrl: '',
                userName: 'Reetu',
                date: '12/122022',
                rating: '2.5',
                review: 'This my review',
              ),
              ReportCardWidgets(
                onTap: () => Get.toNamed(RoutesName.reportScreen,arguments: controller.data.rId),
              ),
              const SizedBox(
                height: 16,
              ),
              if(controller.data.houseFAQ!.isNotEmpty)
              const Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Column(
                children: controller.data.houseFAQ!.map((faq) {
                  // Mapping each FAQ item to a FAQTile widget
                  return FAQWidgets(
                    question: faq.question!,
                    answer: faq.answer!,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CostText extends StatelessWidget {
  const CostText({
    super.key, required this.title, required this.cost,
  });

  final String title;
  final String cost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '₹$cost/-',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
