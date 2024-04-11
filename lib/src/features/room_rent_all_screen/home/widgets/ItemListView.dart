import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../details_rent_screen/controller/details_screen_controller.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.rentList,
    this.snapshot,
  });

  final List<UserRentModel> rentList;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    final size = MediaQuery.of(context).size;


    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 0.2, right: 0.2),
        itemCount: rentList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final itemId = snapshot.data?.docs[index].id;

              Get.toNamed(RoutesName.detailsRentInfoScreen, arguments: {
                'list': rentList[index],
                'id': itemId,
              });
            },

            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 180, maxHeight: 400),
              decoration: BoxDecoration(color: dark ? AppColors.dark : Colors.black12, boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0.1,
                  blurRadius: .1,
                )
              ]),
              child: Stack(
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                            const BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 2, offset: Offset(2, 4)),
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                                imageUrl: '${rentList[index].coverImage}',
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                      height: 400,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent,
                                      ),
                                      child: const SpinKitFadingCircle(
                                        color: AppColors.primary,
                                        size: 35,
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                      width: 150,
                                      height: 280,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.image_outlined,
                                        size: 50,
                                      ),
                                    )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        const Gap(8),
                                        Text(
                                          "${rentList[index].average}  ",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // InkWell(
                                  //   borderRadius: BorderRadius.circular(24),
                                  //   splashColor: Colors.grey,
                                  //   onTap: (){
                                  //
                                  //
                                  //   },
                                  //   child: const CircleAvatar(
                                  //     backgroundColor: Colors.red,
                                  //     foregroundColor: Colors.white,
                                  //     child: Icon(
                                  //       Icons.favorite,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              const Spacer(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.3),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 6,
                                      sigmaY: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Text(
                                                "${rentList[index].houseName}",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                            const Spacer(),
                                            RichText(
                                              text: TextSpan(
                                                text: '₹',
                                                style: const TextStyle(color: Colors.white), //DefaultTextStyle.of
                                                // (context)
                                                // .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: (rentList[index].singlePersonPrice!.isNotEmpty)
                                                          ? '${rentList[index].singlePersonPrice}'
                                                          : '${rentList[index].familyPrice}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                                  const TextSpan(text: '/-monthly'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(6),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_city,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const Gap(6),
                                            Flexible(
                                              child: Text(
                                                "${rentList[index].address} ",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 2,
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(6),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const Gap(6),
                                            Text(
                                              "${rentList[index].city}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const Gap(20),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                                              child: (rentList[index].bhkType!.isEmpty)
                                                  ? Text(
                                                      "Only ${rentList[index].roomType}",
                                                      style:
                                                          const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                                    )
                                                  : Text("${rentList[index].roomType} ${rentList[index].bhkType}",
                                                      style: const TextStyle(color: Colors.white)),
                                            ),
                                            const Gap(20),
                                            InkWell(
                                              onTap: (){},
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: Colors.blue, width: 2)),
                                                  child: const Text(
                                                    "Call Now",
                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // child: Container(
            //
            //   width: double.infinity,
            //   constraints: BoxConstraints(
            //     minHeight: 180,
            //     maxHeight: 200
            //   ),
            //   decoration: BoxDecoration(
            //       color: dark ? AppColors.dark : const Color.fromRGBO(200, 200, 40, 0.01),
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.white,
            //           spreadRadius: 0.2,
            //         )
            //       ]),
            //   child: Row(
            //     children: [
            //       //====== front image========
            //       Container(
            //         width: 150,
            //         height: 280,
            //         color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
            //         child: CachedNetworkImage(
            //             imageUrl: '${rentList[index].coverImage}',
            //             fit: BoxFit.fill,
            //             placeholder: (context, url) => Container(
            //                   color: Colors.transparent,
            //                   height: 100,
            //                   width: 100,
            //                   child: const SpinKitFadingCircle(
            //                     color: AppColors.primary,
            //                     size: 35,
            //                   ),
            //                 ),
            //             errorWidget: (context, url, error) => Container(
            //                   width: 150,
            //                   height: 280,
            //                   alignment: Alignment.center,
            //                   child: const Icon(
            //                     Icons.image_outlined,
            //                     size: 50,
            //                   ),
            //                 )),
            //       ),
            //
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       // =====Details ============
            //
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Flexible(
            //               child: Text(
            //                 "${rentList[index].houseName}",
            //                 overflow: TextOverflow.ellipsis,
            //                 softWrap: false,
            //                 maxLines: 1,
            //                 style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             Row(
            //               children: [
            //                 const Icon(
            //                   Icons.star,
            //                   color: Colors.yellow,
            //                   size: 17,
            //                 ),
            //                 Text("${rentList[index].average}"),
            //                  Text(" (${rentList[index].numberOfRating} Reviews)")
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             RichText(
            //               text: TextSpan(
            //                 text: 'Rent - ₹',
            //                 style: DefaultTextStyle.of(context).style,
            //                 children: <TextSpan>[
            //                   TextSpan(
            //                       text: (rentList[index].singlePersonPrice!.isNotEmpty)
            //                           ? '${rentList[index].singlePersonPrice}'
            //                           : '${rentList[index].familyPrice}',
            //                       style: const TextStyle(fontWeight: FontWeight.bold)),
            //                   const TextSpan(text: ' /- monthly'),
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             Flexible(
            //               child: Text(
            //                 "Address:-${rentList[index].address} ",
            //                 overflow: TextOverflow.ellipsis,
            //                 softWrap: false,
            //                 maxLines: 2,
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 3,
            //             ),
            //             Text("City - ${rentList[index].city}"),
            //             (rentList[index].bhkType!.isEmpty)
            //                 ? Text("Room Type - ${rentList[index].roomType}")
            //                 : Text("Room Type - ${rentList[index].roomType} - ${rentList[index].bhkType}"),
            //
            //             const SizedBox(
            //               height: 3,
            //             ),
            //
            //             (rentList[index].roomAvailable!)
            //             ?  Text("Available :- ${rentList[index].numberOfRooms}",style: TextStyle(color: Colors.green),)
            //                 : Text("Not Available",style: TextStyle(color: Colors.red),)
            //
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          );
        });
  }
}
