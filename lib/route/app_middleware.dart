import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/storage_helper.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final username = StorageHelper.instance.read<String>(
      AppConstants.usernameKey,
    );
    final ahpModel = StorageHelper.instance.read<Map<String, dynamic>>(
      AppConstants.ahpModelKey,
    );

    if (username != null) {
      if (ahpModel != null) {
        return const RouteSettings(name: Routes.selection);
      }

      return const RouteSettings(name: "${Routes.model}/${Routes.create}");
    }

    return null;
  }
}
