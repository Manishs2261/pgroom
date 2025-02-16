import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_collection.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../flavor_config.dart';
import '../../../features/Home_fitter_new/new_search_home/controller.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../data_constant.dart';

class ApisClass {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;

  // for accessing cloud firestorm database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static var coverImageDownloadUrl;
  static var userRentId = "";
  static var otherDownloadUrl;
  static var reviewId = "";
  static var starOne;
  static var starTwo;
  static var starThree;
  static var starFour;
  static var starFive;
  static var averageRating;
  static var totalNumberOfStar;

  static String coverImageFileId = '';

  // upload  Cover image data in firebase database
  static Future uploadCoverImage(File imageFile) async {
    try {
      final reference =
          storage.ref().child('coverImage/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileId = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      coverImageDownloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//============== Edit Post Room Data APis ===================

  //upload other images in firebase database
  static Future uploadOtherImage(File imageFile, itemId) async {
    try {
      final reference =
          storage.ref().child('otherImage/$itemId/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      otherDownloadUrl = await snapshot.ref.getDownloadURL();
      //rent collection data base
      await firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection("$itemId")
          .add({'OtherImage': otherDownloadUrl}).then((value) async {
        AppLoggerHelper.info(value.id);
        userRentId = value.id;
//user personal collection data base
        await firebaseFirestore
            .collection("OtherImageList")
            .doc(itemId)
            .collection("$itemId")
            .doc(userRentId)
            .set({'OtherImage': otherDownloadUrl});

        return null;
      });
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryData(itemId) async {
    var collection = firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOne = data?['ratingStar01'] ?? 0;
    starTwo = data?['ratingStar02'] ?? 0;
    starThree = data?['ratingStar03'] ?? 0;
    starFour = data?['ratingStar04'] ?? 0;
    starFive = data?['ratingStar05'] ?? 0;
    totalNumberOfStar = data?['totalNumberOfStar'] ?? 0;
    averageRating = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryData(
      itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .set({
      'ratingStar01': one,
      'ratingStar02': two,
      'ratingStar03': three,
      'ratingStar04': four,
      'ratingStar05': five,
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    });
  }

  //update Rating bar summary data
  static Future<void> updateRatingBarStarSummaryData(
      itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .update({
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    }).then((value) {
      AppLoggerHelper.info("Update Rating bar average successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar average successfully");
    });
  }

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewData(itemId) async {
    var collection = firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId);

    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';

    return reviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateData(
      ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(itemId)
        .set({
      'itemId': itemId,
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });
  }

  //add ratings in  user collection  and rent list collection
  static Future<void> addRatingMainList(itemId, average, numberOfRating) async {
    //rent collection data base
    await firebaseFirestore
        .collection("rentCollection")
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
  }

  //=======================================================

//=========================================================

//============== Deletes data apis =========================

  // delete cover image  data and all list collection data  code
  static Future<void> deleteCoverImageData(
      String deleteId, String imageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference = firebaseFirestore
          .collection('userRentDetails')
          .doc(user.uid)
          .collection(user.uid)
          .doc(deleteId);

      DocumentReference documentReference1 =
          firebaseFirestore.collection('rentCollection').doc(deleteId);

      //Rating Summary data
      await firebaseFirestore
          .collection("userReview")
          .doc("reviewCollection")
          .collection(deleteId)
          .doc(deleteId)
          .collection("reviewSummary")
          .doc(deleteId)
          .delete();

      // This review  data save in user account only
      await firebaseFirestore
          .collection("loginUser")
          .doc(user.uid)
          .collection(auth.currentUser!.uid)
          .doc(deleteId)
          .delete();

// delete other image in firebase storage

      if (kDebugMode) {
        print('id - $deleteId');
      }

      await FirebaseStorage.instance
          .ref("otherImage/$deleteId")
          .listAll()
          .then((value) {
        value.items.forEach((element) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        });
      });

      //delete other image doc

      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore
          .collection("OtherImageList")
          .doc(deleteId)
          .collection(deleteId);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      final batch1 = firebaseFirestore.batch();
      var collection1 = firebaseFirestore
          .collection("OtherImageUserList")
          .doc(deleteId)
          .collection(deleteId);
      var snapshots1 = await collection1.get();
      for (var doc in snapshots1.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();

      //delete a review collection data

      final batch2 = firebaseFirestore.batch();
      var collection2 = firebaseFirestore
          .collection("userReview")
          .doc("reviewCollection")
          .collection(deleteId);
      var snapshots2 = await collection2.get();
      for (var doc in snapshots2.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();

      // // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  //delete Other image data
  static Future<void> deleteOtherImage(
      String deleteOtherIMageId, String itemId, String imageUrl) async {
    try {
      DocumentReference documentReference = firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection(itemId)
          .doc(deleteOtherIMageId);

      DocumentReference documentReference1 = firebaseFirestore
          .collection("OtherImageList")
          .doc(itemId)
          .collection(itemId)
          .doc(deleteOtherIMageId);

      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static final homeController = Get.put(HomeController());

  static Future<bool> addRoomData({
    required String homeName,
    required String latitude,
    required String longitude,
    required String address,
    required String landmark,
    required String city,
    required String state,
    required List<String> commonAreasList,
    required List<String> roomFacilityList,
    required String roomType,
    required List<String> billsList,
    required List<File> imageFiles,
    required List<HouseFAQ> houseFAQ,
    required String roomOwnership,
    required String roomCategory,
    required String depositAmount,
    required String singlePersonCost,
    required String doublePersonCost,
    required String triplePersonCost,
    required String triplePlusCost,
    required String familyCost,
    required String roomsAvailable,
    required String noticePride,
    required String mealsAvailable,
    required List<String> houseRules,
    required String genderType,
    required String totalRoom,
    required String flatType,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);
    if (homeController.user.isNotEmpty) {
      try {
        List<String> imageUrls = [];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? userDocId = preferences.getString('userDocId');
        // Step 1: Prepare the data to save in Firestore
        final item = RoomModel(
            longitude: longitude,
            latitude: latitude,
            billsList: billsList,
            commonAreasList: commonAreasList,
            depositAmount: depositAmount,
            doublePersonCost: doublePersonCost,
            genderType: genderType,
            houseFAQ: houseFAQ,
            houseName: homeName,
            houseRules: houseRules,
            imageList: imageUrls,
            roomCategory: roomCategory,
            roomFacilityList: roomFacilityList,
            roomOwnershipType: roomOwnership,
            roomType: roomType,
            singlePersonCost: singlePersonCost,
            triplePersonCost: triplePersonCost,
            triplePlusCost: triplePlusCost,
            mealsAvailable: mealsAvailable,
            familyCost: familyCost,
            isRoomAvailableDate: roomsAvailable,
            noticePride: noticePride,
            rId: '',
            totalRoom: totalRoom,
            homeAddress: address,
            landmark: landmark,
            city: city,
            state: state,
            atCreate: DateTime.now().toString(),
            atUpdate: DateTime.now().toString(),
            isDelete: false,
            report: [],
            disable: false,
            uId: user.uid,
            flatType: flatType,
            userDocId: userDocId,
            mobileNumber: homeController.user.first.phone,
            userName: homeController.user.first.name,
            userImage: homeController.user.first.image);

        // Step 2: Add the data to Firestore
        try {
          DocumentReference docRef = await FirebaseFirestore.instance
              .collection(
                  "${AppEnvironment.environmentName}_${CollectionName.room}")
              .add(item.toJson())
              .timeout(const Duration(seconds: 2000), onTimeout: () {
            Navigator.pop(Get.context!);
            throw TimeoutException(
                "The operation timed out after 2000 seconds");
          });

          for (File imageFile in imageFiles) {
            try {
              String imageUrl =
                  await uploadImageToFirebase(imageFile, docRef.id);
              imageUrls.add(imageUrl);
            } catch (e) {
              AppLoggerHelper.error("Error uploading image: $e");
              Navigator.pop(Get.context!);
              return false; // If any image fails to upload, return false
            }
          }

          // Update the document with its ID and image list
          await FirebaseFirestore.instance
              .collection(
                  "${AppEnvironment.environmentName}_${CollectionName.room}")
              .doc(docRef.id)
              .update({'r_id': docRef.id, 'imageList': imageUrls}).whenComplete(
                  () {
            AppLoggerHelper.info(
                "Document added successfully with ID: ${docRef.id}");
          });

          // Step 3: Add the room ID to the user's roomId list
          try {
            // Add the new room ID to the roomId list
            await FirebaseFirestore.instance
                .collection(
                    "${AppEnvironment.environmentName}_${CollectionName.user}")
                .doc(userDocId)
                .update({
              'roomId': FieldValue.arrayUnion([docRef.id]),
            });

            AppLoggerHelper.info(
                "Room ID ${docRef.id} successfully added to user's roomId list.");
          } catch (e) {
            Navigator.pop(Get.context!);
            AppLoggerHelper.error("Error updating user's roomId: $e");
            return false; // Handle errors gracefully
          }

          Navigator.pop(Get.context!);
          return true; // Successfully saved data
        } catch (e) {
          Navigator.pop(Get.context!);

          if (e is TimeoutException) {
            AppHelperFunction.showFlashbar('Timeout error: ${e.message}');
            AppLoggerHelper.info("Timeout error: ${e.message}");
          } else if (e is FirebaseException) {
            AppHelperFunction.showFlashbar('Firestore error: ${e.message}');
            AppLoggerHelper.info("Firestore error: ${e.message}");
          } else {
            AppHelperFunction.showFlashbar('General error: ${e}');
            AppLoggerHelper.info("General error: $e");
          }
          return false; // Return false on Firestore save failure
        }
      } catch (e) {
        Navigator.pop(Get.context!);
        AppLoggerHelper.error("Error adding document: $e");
        return false; // Return false for general errors
      }
    } else {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar("Something went wrong. Please try again.");
      AppLoggerHelper.error("Something went wrong. Please try again.");
      return false;
    }
  }

  static Future<String> uploadImageToFirebase(File imageFile, docId) async {
    try {
      final reference = FirebaseStorage.instance.ref().child(
          '${AppEnvironment.environmentName}_${CollectionName.room}/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      AppLoggerHelper.info("Image uploaded successfully: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      AppLoggerHelper.error("Image upload failed: $e");
      throw Exception("Image upload failed");
    }
  }

  static Future<void> submitReport(
      {required String reportReason,
      required String docId,
      required String roomCollection}) async {
    try {
      await FirebaseFirestore.instance
          .collection(roomCollection)
          .doc(docId)
          .update({
        'report': FieldValue.arrayUnion([
          {
            'date': DateTime.now().toString(),
            'description': reportReason,
            'userRef': FirebaseFirestore.instance
                .collection('DevUser')
                .doc(FirebaseAuth.instance.currentUser!.uid)
          }
        ])
      }).then((value) {
        Navigator.pop(Get.context!);
        AppLoggerHelper.info("Document updated successfully");
      }).catchError((error) {
        AppLoggerHelper.error("Failed to update document: $error");
      });
    } catch (e) {
      AppHelperFunction.showFlashbar(e.toString());
      AppLoggerHelper.error("Error adding document: $e");
    }
  }

  static Future<bool> submitRoomReviewData({
    required String rating,
    required String userReview,
    required String rId,
  }) async {
    // Get a reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the user document ID
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userDocId = preferences.getString('userDocId');

      //  Create the review data map
      final reviewData = {
        "date": DateTime.now().toIso8601String(),
        "rating": rating,
        "review": userReview,
        "user": firestore
            .collection(
                '${AppEnvironment.environmentName}_${CollectionName.user}')
            .doc(userDocId)
            .path, // Correct user reference
      };

      // // Update the 'reviews' field in the RoomReview collection
      await firestore
          .collection(
              '${AppEnvironment.environmentName}_${CollectionName.review}')
          .doc(rId)
          .set({
        "reviews": FieldValue.arrayUnion([reviewData]),
        // Add to an array of reviews
      }, SetOptions(merge: true)); // Avoid overwriting the document
      AppLoggerHelper.info("Document updated successfully");
      return true; // Return true when successful
    } catch (e) {
      // Catch any errors and handle them appropriately
      if (e is FirebaseException) {
        // Firestore-specific exception
        AppLoggerHelper.error("Firestore error: $e");
      } else {
        // Generic error
        AppLoggerHelper.error("General error: $e");
      }
      AppLoggerHelper.error("Error adding document: $e");
      return false; // Return false if an error occurs
    }
  }

  static Future<bool> updateRoomDetailsData({
    required String documentId,
    required String roomOwnershipType,
    required String houseName,
    required String roomCategory,
    required String genderType,
    required String roomType,
    required String flatType,
    required List<File> imageFiles,
    required List<String> imageUrlsList,
    required String bhkCost,
    required String singlePersonCost,
    required String doublePersonCost,
    required String triplePersonCost,
    required String triplePlusCost,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      List<String> imageUrls = List.from(imageUrlsList);

      final updatedItem = {
        'triple_person_cost': triplePersonCost,
        'double_person_cost': doublePersonCost,
        'triple_plus_cost': triplePlusCost,
        'single_person_cost': singlePersonCost,
        'houseName': houseName,
        'roomType': roomType,
        'genderType': genderType,
        'roomCategory': roomCategory,
        'roomOwnershipType': roomOwnershipType,
        'family_cost': bhkCost,
        'flatType': flatType,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.room}")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      if (imageFiles.isNotEmpty) {
        // Deleting old images
        for (String imageUrl in imageUrlsList) {
          await deleteImageFromFirebase(imageUrl);
        }

        imageUrls.clear();

        // Uploading new images
        for (File imageFile in imageFiles) {
          try {
            String imageUrl =
                await uploadImageToFirebase(imageFile, documentId);
            imageUrls.add(imageUrl);
          } catch (e) {
            AppLoggerHelper.error("Error uploading image: $e");
            Navigator.pop(Get.context!);
            return false;
          }
        }

        await FirebaseFirestore.instance
            .collection(
                "${AppEnvironment.environmentName}_${CollectionName.room}")
            .doc(documentId)
            .update({'imageList': imageUrls}).whenComplete(() {
          Navigator.pop(Get.context!);
          AppLoggerHelper.info("Document updated successfully");
        });
      } else {
        Navigator.pop(Get.context!);
        AppLoggerHelper.info('No images to update');
      }
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: $e");
      return false;
    }
  }

  static Future<bool> updateRoomAddressData({
    required String documentId,
    required String address,
    required String landmark,
    required String city,
    required String state,
    required String totalRoom,
    required String isMealsAvailable,
    required String depositAmount,
    required List<String> facilities,
    required List<String> commonArea,
    required List<String> bills,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      final updatedItem = {
        'address': address,
        'landmark': landmark,
        'city': city,
        'state': state,
        'totalRoom': totalRoom,
        'mealsAvailable': isMealsAvailable,
        'depositAmount': depositAmount,
        'roomFacilityList': facilities,
        'commonAreasList': commonArea,
        'billsList': bills,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.room}")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      AppLoggerHelper.info("Document updated successfully");
      Navigator.pop(Get.context!);
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: \$e");
      return false;
    }
  }

  static Future<bool> updateHouseFaqAndRulesData({
    required String documentId,
    required List<HouseFAQ> faqs,
    required List<String> houseRules,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      final updatedItem = {
        'houseRules': houseRules,
        'houseFAQ': faqs,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.room}")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      AppLoggerHelper.info("Document updated successfully");
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: \$e");
      return false;
    }
  }

  static Future<bool> updateRoomMapData({
    required String latitude,
    required String longitude,
    required String documentId,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      final updatedItem = {
        'latitude': latitude,
        'longitude': longitude,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.room}")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 2000), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      AppLoggerHelper.info("Document updated successfully");
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: $e");
      return false;
    }
  }

  static Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
      AppLoggerHelper.info("Image deleted successfully");
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static Future<bool> deleteRoomData(
      {required String documentId, required List<String> imageUrls}) async {
    AppHelperFunction.showCenterCircularIndicator(true);
    try {
      // Delete images from storage
      for (String imageUrl in imageUrls) {
        await deleteImageFromFirebase(imageUrl);
      }

      // Delete Firestore document
      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.room}")
          .doc(documentId)
          .delete();

      AppLoggerHelper.info("Document and images deleted successfully");
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      return true;
    } catch (e) {
      AppLoggerHelper.error("Error deleting document and images: $e");
      return false;
    }
  }
}
