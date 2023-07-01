import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final appBox = BoxHelper(name: AppBoxes.app);
    final username = appBox.getValue(AppBoxes.usernameKey);
    final ahpModel = appBox.getValue(AppBoxes.ahpModelKey);

    if (username != null) {
      if (ahpModel != null) {
        return const RouteSettings(name: Routes.selection);
      }

      return const RouteSettings(name: "${Routes.model}/${Routes.create}");
    }

    return null;
  }
}
