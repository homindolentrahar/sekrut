import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/features/selection/domain/models/ahp_model.dart';
import 'package:sekrut/util/helpers/storage_helper.dart';

class ModelRepository {
  Future<void> saveModel(AHPModel model) async {
    await StorageHelper.instance.write(
      AppConstants.ahpModelKey,
      model,
    );
  }

  AHPModel? getModel() {
    final result = StorageHelper.instance.read<Map<String, dynamic>>(
      AppConstants.ahpModelKey,
    );

    return result != null ? AHPModel.fromJson(result) : null;
  }
}
