import 'package:get/get.dart';
import 'package:sekrut/core/presentation/pages/landing/landing_controller.dart';
import 'package:sekrut/core/presentation/pages/landing/landing_page.dart';
import 'package:sekrut/core/presentation/pages/loader/loader_controller.dart';
import 'package:sekrut/core/presentation/pages/loader/loader_page.dart';
import 'package:sekrut/features/selection/presentation/pages/alternative/crud_alternative_binding.dart';
import 'package:sekrut/features/selection/presentation/pages/alternative/crud_alternative_page.dart';
import 'package:sekrut/features/selection/presentation/pages/model/crud_model_binding.dart';
import 'package:sekrut/features/selection/presentation/pages/selection/crud_selection_page.dart';
import 'package:sekrut/features/selection/presentation/pages/selection/detail_selection_page.dart';
import 'package:sekrut/features/selection/presentation/pages/model/crud_model_page.dart';
import 'package:sekrut/features/selection/presentation/pages/selection/selection_page.dart';
import 'package:sekrut/route/app_middleware.dart';

abstract class Routes {
  static const String loader = "/";
  static const String landing = "/landing";
  static const String selection = "/selections";
  static const String model = "/models";
  static const String alternative = "/alternative";

  static const String create = "create";
}

abstract class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.loader,
      page: () => const LoaderPage(),
      binding: BindingsBuilder(() {
        Get.put(LoaderController());
      }),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.landing,
      page: () => const LandingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LandingController());
      }),
      transition: Transition.rightToLeftWithFade,
      middlewares: [
        AppMiddleware(),
      ],
    ),
    GetPage(
      name: "${Routes.model}/${Routes.create}",
      page: () => const CrudModelPage(),
      binding: CrudModelBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: "${Routes.model}/:id",
      page: () => const CrudModelPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.selection,
      page: () => const SelectionPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: "${Routes.selection}/${Routes.create}",
      page: () => const CrudSelectionPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: "${Routes.selection}/:id",
      page: () => const DetailSelectionPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: "${Routes.alternative}/${Routes.create}",
      page: () => const CrudAlternativePage(),
      transition: Transition.rightToLeftWithFade,
      binding: CrudAlternativeBinding(),
    ),
  ];
}
