import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pgroom/src/features/Help_screen/help_screen.dart';
import 'package:pgroom/src/features/Home_fitter_new/city_search/city_search.dart';
import 'package:pgroom/src/features/Rooms_screen_new/details_rooms/details_room.dart';
import 'package:pgroom/src/features/Rooms_screen_new/list_of_rooms/list_of_rooms.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_first_form/room_post_first_form.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_fourth_form/room_post_fourth_form.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_second_form/room_post_second_form.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_third_form/room_post_third_form.dart';
import 'package:pgroom/src/features/auth_screen/delete_account/delete_account.dart';
import 'package:pgroom/src/features/auth_screen/re_auth/re_authentication/re_auth_screen.dart';
import 'package:pgroom/src/features/auth_screen/sing_profile_screen/sing_profile_screen.dart';
import 'package:pgroom/src/features/chats_screen/list_of_chats_sceen/list_of_chat_screen.dart';
import 'package:pgroom/src/features/contacts_us/contacts.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_details_screen/food_details_screen.dart';
import 'package:pgroom/src/features/foods_screen_new/list_of_foods_screen/list_of_foods_screen.dart';
import 'package:pgroom/src/features/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:pgroom/src/features/profile_screen/edit_profile_screen/profile_screen.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/List_of_sell_and_buy/List_of_sell_and_buy.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/details_of_sell_and_buy/details_of_sell_and_buy.dart';
import 'package:pgroom/src/features/services_screen/details_services/details_services.dart';
import 'package:pgroom/src/features/services_screen/list_of_services/list_of_services.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/first_services_form/first_services_form.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/seconds_service_screen/second_services_form.dart';
import 'package:pgroom/src/navigation_menu.dart';

import '../../features/Home_fitter_new/List_of_post/List_of_post.dart';
import '../../features/Home_fitter_new/filter/filter.dart';
import '../../features/Home_fitter_new/location_search/location_search.dart';
import '../../features/Home_fitter_new/new_search_home/new_home_screen.dart';
import '../../features/Home_fitter_new/view_your_post/view_screen/food_update/food_update.dart';
import '../../features/Home_fitter_new/view_your_post/view_screen/room_update/room_update.dart';
import '../../features/Home_fitter_new/view_your_post/view_screen/sell_and_buy_update/sell_and_buy_update.dart';
import '../../features/Home_fitter_new/view_your_post/view_screen/services_update/services_update.dart';
import '../../features/Home_fitter_new/view_your_post/view_your_post.dart';
import '../../features/Rooms_screen_new/update_post/edit_room.dart';
import '../../features/Rooms_screen_new/update_post/update_form/first_screen/first_form_update.dart';
import '../../features/Rooms_screen_new/update_post/update_form/fourth_screen/fourth_form_update.dart';
import '../../features/Rooms_screen_new/update_post/update_form/second_screen/second_form_update.dart';
import '../../features/Rooms_screen_new/update_post/update_form/third_screen/third_form_update.dart';
import '../../features/auth_screen/forget_password_email/forget_password.dart';
import '../../features/auth_screen/login_screen/login_screen.dart';
import '../../features/auth_screen/sing_in_screen/sing_in_screen.dart';
import '../../features/foods_screen_new/foods_form_screen/first_food_form/first_food_form.dart';
import '../../features/foods_screen_new/foods_form_screen/fourth_food_form/fourth_food_form.dart';
import '../../features/foods_screen_new/foods_form_screen/second_food_form/second_food_form.dart';
import '../../features/foods_screen_new/foods_form_screen/third_food_form/third_food_form.dart';
import '../../features/foods_screen_new/foods_update_screen/first_food_update_screen/first_food_update_screen.dart';
import '../../features/foods_screen_new/foods_update_screen/fourth_food_update_screen/fourth_food_update_screen.dart';
import '../../features/foods_screen_new/foods_update_screen/second_food_update_screen/second_food_update_screen.dart';
import '../../features/foods_screen_new/foods_update_screen/third_food_update_screen/third_food_update_screen.dart';
import '../../features/on_boarding_screen/on_boarding_screen.dart';
import '../../features/profile_screen/profile_main_screen.dart';
import '../../features/report_screen/report_screen.dart';
import '../../features/sell_and_buy_screen/sell_and_buy_form/sell_and_buy_form.dart';
import '../../features/sell_and_buy_screen/update_post/first_screen/first_screen.dart';
import '../../features/services_screen/services_form_screen/third_service_form/third_services_form.dart';
import '../../features/services_screen/update_post/edit_services.dart';
import '../../features/services_screen/update_post/first_screen/first_update_screen.dart';
import '../../features/services_screen/update_post/second_update_screen/second_update.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/view_all_review/view_all_review.dart';
import '../route_name/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.SplashScreen,
            page: () => SplashScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.onboradingScreen,
            page: () => const OnBoardingOneScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.loginScreen,
            page: () => LoginScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.singScreen,
            page: () => SingInScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.emailForgetPassScreen,
            page: () => ForgetPasswordEmailScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.viewAllReview,
            page: () => ViewAllReviewScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.signProfileScreen,
            page: () => SignProfileScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.editPofileScreen,
            page: () => EditProfileScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.profileSCreen,
            page: () => ProfileScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.navigationScreen,
            page: () => const NavigationMenuScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.helpScreen,
            page: () => const HelpScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.reAuthScreen,
            page: () => ReAuthScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.deleteAccountScreen,
            page: () => const DeleteAccountScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.contactsUs,
            page: () => const ContactsUs(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        ///new router screen

        GetPage(
            name: RoutesName.homeNew,
            page: () => const HomeNew(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.filter,
            page: () => const FilterScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.locationSearch,
            page: () => LocationSearch(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.listOfRooms,
            page: () => ListOfRooms(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.roomDetails,
            page: () => DetailsRoom(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.listOfFoods,
            page: () => ListOfFoods(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.foodDetails,
            page: () => const DetailsFood(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.listOfSellAndBuy,
            page: () => ListOfSellAndBuy(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.sellAndBuyDetails,
            page: () => DetailsOfSellAndBuy(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.listOfServices,
            page: () => const ListOfServices(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.servicesDetails,
            page: () => DetailsServices(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.listOfChats,
            page: () => const ListOfChatScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.roomPostForm,
            page: () => FirstRoomFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.listOfPost,
            page: () => const ListOfPost(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.citySearch,
            page: () => CitySearch(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.firstRoomFormScreen,
            page: () => FirstRoomFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.secondRoomFormScreen,
            page: () => SecondRoomFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.thirdRoomFormScreen,
            page: () => ThirdRoomFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.fourthRoomFormScreen,
            page: () => FourthRoomFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        /// for food form screen

        GetPage(
            name: RoutesName.firstFoodFormScreen,
            page: () => FirstFoodForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.secondFoodFormScreen,
            page: () => SecondFoodForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.thirdFoodFormScreen,
            page: () => ThirdFoodForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.fourthFoodFormScreen,
            page: () => FourthFoodForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.firstServiceFormScreen,
            page: () => FirstServicesForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.secondServiceFormScreen,
            page: () => SecondServicesForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.profileDetailsScreen,
            page: () => const ProfileDetailsScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.sellAndBuyForm,
            page: () => SellAndBuyForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.thirdServicesForm,
            page: () => ThirdServicesForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.reportScreen,
            page: () => ReportScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.editPostList,
            page: () => EditPostList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.foodUpdateList,
            page: () => FoodUpdateList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.roomUpdateList,
            page: () => RoomUpdateList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.servicesUpdateList,
            page: () => ServicesUpdateList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.sellAndBuyUpdateList,
            page: () => SellAndBuyUpdateList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.firstUpdateServicesForm,
            page: () => FirstUpdateServicesForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.secondUpdateServicesForm,
            page: () => SecondUpdateServicesForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.editServicesPostList,
            page: () => EditServicesPostList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.sellAndBuyUpdateForm,
            page: () => SellAndBuyUpdateForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.editRoomPostList,
            page: () => EditRoomPostList(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.firstRoomUpdateFormScreen,
            page: () => FirstRoomUpdateFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesName.secondRoomUpdateFormScreen,
            page: () => SecondRoomUpdateFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.thirdRoomUpdateFormScreen,
            page: () => ThirdRoomUpdateFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.fourthRoomUpdateFormScreen,
            page: () => FourthRoomUpdateFormScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.firstFoodUpdateForm,
            page: () => FirstFoodUpdateForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.secondFoodUpdateForm,
            page: () => SecondFoodUpdateForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.thirdFoodUpdateForm,
            page: () => ThirdFoodUpdateForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
            name: RoutesName.fourthFoodUpdateForm,
            page: () => FourthFoodUpdateForm(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
      ];
}
