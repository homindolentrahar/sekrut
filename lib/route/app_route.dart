import 'package:get/get.dart';
import 'package:sekrut/core/presentation/pages/loader_page.dart';

abstract class Routes {
  static const String loader = "/";
}

abstract class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.loader,
      page: () => const LoaderPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
