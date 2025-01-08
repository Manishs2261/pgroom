import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Rooms_screen_new/list_of_rooms/controller/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';

class ListOfRooms extends StatefulWidget {
  const ListOfRooms({super.key});

  @override
  State<ListOfRooms> createState() => _ListOfRoomsState();
}

class _ListOfRoomsState extends State<ListOfRooms> {
  final listOfRoomController = Get.put(ListOfRoomController());
  Set<int> selectedIndices = {};
  RxString selectedAccommodationType = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedRoomType = ''.obs;
  RxString selectedFlatType = ''.obs;
  RxString selectedFurnishedType = ''.obs;
  RxString selectedFood = ''.obs;
  RxList<String> furnishedType =
      ['Un Furnished', 'semi Furnished', 'Fully Furnished'].obs;
  RxList<String> food = ['Yes', 'No'].obs;
  RxList<String> roomType =
      ['Private Room', 'Double Sharing', 'Triple Sharing', '3+ Sharing'].obs;
  Rx<RangeValues> _budgetRange = RangeValues(500, 100000).obs;
  RxList<String> accommodationType = ['PG', 'Flat', 'Co-living'].obs;
  RxList<String> gender = ['Boy', 'Girl', 'Both'].obs;
  RxList<String> flatType = ['1RK', '1BHK', '2BHK', '3BHK', '4BHK'].obs;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug('ListOfRooms........');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: TopSearchFilter()),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: listOfRoomController.isButtonVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: listOfRoomController.isButtonVisible.value
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: AppColors.white,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            // Start at 50% of screen height
                            minChildSize: 0.3,
                            // Minimum height: 30% of screen height
                            maxChildSize: 0.9,
                            // Maximum height: 90% of screen height
                            expand: false,
                            builder: (builder, scrollController) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(10.0),
                                              topRight:
                                                  const Radius.circular(10.0))),
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        primary: false,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'I am looking to:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Obx(
                                              () => Wrap(
                                                spacing: 8,
                                                children: accommodationType
                                                    .map(
                                                      (type) => FilterChip(
                                                        label: Text(type),
                                                        labelStyle: TextStyle(
                                                            color:
                                                                selectedAccommodationType ==
                                                                        type
                                                                    ? Colors.white
                                                                    : Colors
                                                                        .black),
                                                        selected:
                                                            selectedAccommodationType ==
                                                                type,
                                                        selectedColor:
                                                            AppColors.primary,
                                                        backgroundColor: Colors
                                                            .blue
                                                            .withOpacity(0.08),
                                                        // Set color to blue when selected
                                                        onSelected: (selected) {
                                                          setState(() {
                                                            if (selected) {
                                                              selectedAccommodationType
                                                                  .value = type;
                                                            } else {
                                                              selectedAccommodationType
                                                                      .value =
                                                                  ''; // Deselect when tapped again
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    (selectedAccommodationType ==
                                                        'PG'),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Gender:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Wrap(
                                                      spacing: 8,
                                                      children: gender
                                                          .map(
                                                            (type) => FilterChip(
                                                              label: Text(type),
                                                              labelStyle: TextStyle(
                                                                  color: selectedGender ==
                                                                          type
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                              selected:
                                                                  selectedGender ==
                                                                      type,
                                                              selectedColor:
                                                                  AppColors
                                                                      .primary,
                                                              backgroundColor:
                                                                  Colors.blue
                                                                      .withOpacity(
                                                                          0.08),
                                                              // Set color to blue when selected
                                                              onSelected:
                                                                  (selected) {
                                                                setState(() {
                                                                  if (selected) {
                                                                    selectedGender
                                                                            .value =
                                                                        type;
                                                                  } else {
                                                                    selectedGender
                                                                            .value =
                                                                        ''; // Deselect when tapped again
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    (selectedAccommodationType ==
                                                        'PG'),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Room Type:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      // Set the scroll direction to horizontal
                                                      child: Wrap(
                                                        spacing: 8,
                                                        // Spacing between chips
                                                        children: roomType
                                                            .map(
                                                              (type) =>
                                                                  FilterChip(
                                                                label: Text(type),
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: selectedRoomType ==
                                                                          type
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                selected:
                                                                    selectedRoomType ==
                                                                        type,
                                                                selectedColor:
                                                                    AppColors
                                                                        .primary,
                                                                backgroundColor:
                                                                    Colors.blue
                                                                        .withOpacity(
                                                                            0.08),
                                                                // Background when not selected
                                                                onSelected:
                                                                    (selected) {
                                                                  setState(() {
                                                                    if (selected) {
                                                                      selectedRoomType
                                                                              .value =
                                                                          type;
                                                                    } else {
                                                                      selectedRoomType
                                                                              .value =
                                                                          ''; // Deselect when tapped again
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    (selectedAccommodationType ==
                                                        'Flat'),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'BHK Type:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      // Set the scroll direction to horizontal
                                                      child: Wrap(
                                                        spacing: 8,
                                                        // Spacing between chips
                                                        children: flatType
                                                            .map(
                                                              (type) =>
                                                                  FilterChip(
                                                                label: Text(type),
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: selectedFlatType ==
                                                                          type
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                selected:
                                                                    selectedFlatType ==
                                                                        type,
                                                                selectedColor:
                                                                    AppColors
                                                                        .primary,
                                                                backgroundColor:
                                                                    Colors.blue
                                                                        .withOpacity(
                                                                            0.08),
                                                                // Background when not selected
                                                                onSelected:
                                                                    (selected) {
                                                                  setState(() {
                                                                    if (selected) {
                                                                      selectedFlatType
                                                                              .value =
                                                                          type;
                                                                    } else {
                                                                      selectedFlatType
                                                                              .value =
                                                                          ''; // Deselect when tapped again
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    const Text(
                                                      'Furnishing Type:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      // Set the scroll direction to horizontal
                                                      child: Wrap(
                                                        spacing: 8,
                                                        // Spacing between chips
                                                        children: furnishedType
                                                            .map(
                                                              (type) =>
                                                                  FilterChip(
                                                                label: Text(type),
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: selectedFurnishedType ==
                                                                          type
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                selected:
                                                                    selectedFurnishedType ==
                                                                        type,
                                                                selectedColor:
                                                                    AppColors
                                                                        .primary,
                                                                backgroundColor:
                                                                    Colors.blue
                                                                        .withOpacity(
                                                                            0.08),
                                                                // Background when not selected
                                                                onSelected:
                                                                    (selected) {
                                                                  setState(() {
                                                                    if (selected) {
                                                                      selectedFurnishedType
                                                                              .value =
                                                                          type;
                                                                    } else {
                                                                      selectedFurnishedType
                                                                              .value =
                                                                          ''; // Deselect when tapped again
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    (selectedAccommodationType ==
                                                            'PG' ||
                                                        selectedAccommodationType ==
                                                            'Co-living'),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Food:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Wrap(
                                                      spacing: 8,
                                                      children: food
                                                          .map(
                                                            (type) => FilterChip(
                                                              label: Text(type),
                                                              labelStyle: TextStyle(
                                                                  color: selectedFood ==
                                                                          type
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                              selected:
                                                                  selectedFood ==
                                                                      type,
                                                              selectedColor:
                                                                  AppColors
                                                                      .primary,
                                                              backgroundColor:
                                                                  Colors.blue
                                                                      .withOpacity(
                                                                          0.08),
                                                              // Set color to blue when selected
                                                              onSelected:
                                                                  (selected) {
                                                                setState(() {
                                                                  if (selected) {
                                                                    selectedFood
                                                                            .value =
                                                                        type;
                                                                  } else {
                                                                    selectedFood
                                                                            .value =
                                                                        ''; // Deselect when tapped again
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Text(
                                              'Budget:',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Obx(
                                              () => RangeSlider(
                                                activeColor: AppColors.primary,
                                                values: _budgetRange.value,
                                                min: 500,
                                                max: 100000,
                                                divisions: 100,
                                                labels: RangeLabels(
                                                  _budgetRange.value.start
                                                      .round()
                                                      .toString(),
                                                  _budgetRange.value.end
                                                      .round()
                                                      .toString(),
                                                ),
                                                onChanged: (RangeValues values) {
                                                  setState(() {
                                                    _budgetRange.value = values;
                                                  });
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Obx(
                                              () => Text(
                                                'Selected Budget: ₹${_budgetRange.value.start.round()} - ₹${_budgetRange.value.end.round()}',
                                                style:
                                                    const TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            const SizedBox(height: 24),

                                          ],
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 20,
                                    child: ReuseElevButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              RoutesName.listOfRooms);
                                        },
                                        title: 'Apply Filter'),
                                  ),
                                ],
                              );
                            });
                      },
                    );

//===
                  },
                  backgroundColor: AppColors.primary,
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ),
      ),
      body: Obx(
        () => listOfRoomController.isLoadingInitial.value
            ? ListView.builder(
                // Shimmer effect during the initial load
                itemCount: 2, // Number of shimmer placeholders
                itemBuilder: (context, index) {
                  return ShimmerEffect(
                    width: double.infinity,
                    height: 200,
                    bottomShimmer: true,
                    bottomWidth: double.infinity,
                    bottomHeight: 20,
                  );
                },
              )
            : CustomMaterialIndicator(
                durations: RefreshIndicatorDurations(
                    settleDuration: Duration(milliseconds: 1000)),
                onRefresh: () async {
                  listOfRoomController.roomListData.clear();
                  listOfRoomController.lastDocument = null;
                  listOfRoomController.hasMoreData.value = true;

                  await listOfRoomController.fetchData();
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                },
                child: listOfRoomController.roomListData.isEmpty &&
                        !listOfRoomController.isLoadingMore.value
                    ? Center(
                        child: Text(
                          'No rooms available. Pull to refresh.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        controller: listOfRoomController.scrollController,
                        itemCount: listOfRoomController.isLoadingMore.value
                            ? listOfRoomController.roomListData.length + 1
                            : listOfRoomController.roomListData.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  listOfRoomController.roomListData.length &&
                              listOfRoomController.isLoadingMore.value) {
                            return SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ));
                          }
                          return RoomListCardWidgets(
                              roomListData:
                                  listOfRoomController.roomListData[index]);
                        },
                      ),
              ),
      ),
    );
  }
}

class RoomListCardWidgets extends StatelessWidget {
  const RoomListCardWidgets({
    super.key,
    required this.roomListData,
  });

  final RoomModel roomListData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.roomDetails, arguments: roomListData),
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 12, right: 12),
        // You can adjust this height to fit the content
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            SizedBox(
              height: 140,
              // Set a fixed height for the PageView
              child: Stack(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomListData.imageList?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              width: Get.width * 0.8,
                              imageUrl:
                                  roomListData.imageList?[imageIndex] ?? '',
                              placeholder: (context, url) => ShimmerEffect(
                                  width: Get.width * 0.8, height: 140),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_outlined),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                  Positioned(
                    top: 1,
                    left: 1,
                    child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: false
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                                size: 20,
                              )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Room details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${roomListData.singlePersonCost.toString()}/-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    '${roomListData.genderType}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${roomListData.houseName?.capitalizeFirst}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.amber,
                  ),
                  child: Text(
                    '${roomListData.roomCategory}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${roomListData.roomType?.capitalizeFirst}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontStyle: FontStyle.italic),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orange,
                    ),
                    const Gap(4),
                    Text(
                      "2.5",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: 4),
            Text(
              '${roomListData.landmark}, ${roomListData.homeAddress}, ${roomListData.city}, ${roomListData.state}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 4),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: CachedNetworkImage(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                imageUrl: roomListData.userImage.toString(),
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                        const ShimmerEffect(
                                            height: 40,
                                            width: 40,
                                            borderRadius: 24),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${roomListData.userName?.capitalizeFirst}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Updated',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              AppHelperFunction.printFormattedDate(
                                  roomListData.atUpdate.toString()),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Buttons for "Chat Now" and "Call Now"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Chat Now Button with Gradient
                        GradientButton(
                          icon: Icons.chat,
                          label: 'Chat Now',
                          colors: [Colors.orange, Colors.red],
                          onPressed: () {
                            // Handle chat action
                          },
                        ),
                        // Call Now Button with Gradient
                        GradientButton(
                          icon: Icons.phone,
                          label: 'Call Now',
                          colors: [Colors.green, Colors.teal],
                          onPressed: () {
                            // Handle call action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
