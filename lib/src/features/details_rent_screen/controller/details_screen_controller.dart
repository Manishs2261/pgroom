import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../model/user_rent_model/user_rent_model.dart';

class DetailsScreenController extends GetxController {
  var itemId;
  UserRentModel data = UserRentModel();

//constructor
  DetailsScreenController(this.itemId, this.data);

  RxBool isView = false.obs;
  final reviewController = TextEditingController().obs;

  //page view controller
  final imageIndicatorController = PageController().obs;

  List<RatingAndReviewModel> ratingList = [];
  var ratingNow = 0.0.obs;

  onSubmitReviewButton() {
   AppHelperFunction.checkInternetAvailability().then((value) {
     if(value){
       //rating is empty, not click a button
       if(ratingNow.value !=0.0) {
         ApisClass.ratingAndReviewCreateData(ratingNow.value, reviewController.value.text, itemId).then((value) {
           reviewController.value.text = '';
           Get.snackbar("Rating Submit", "Successfully");
           ratingNow.value = 0.0;
         }).onError((error, stackTrace) {
           Get.snackbar("Rating Submit", "Failed");
           AppLoggerHelper.error("Rating submit error", error);
           AppLoggerHelper.error("Rating submit error", stackTrace);
         });
       }else{
         AppHelperFunction.showSnackBar("Rating can't be empty.");
       }
     }
   });
  }


}
