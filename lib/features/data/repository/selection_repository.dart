import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class SelectionRepository {
  final BoxHelper selectionBox;

  SelectionRepository(this.selectionBox);

  Future<void> createSelection(Selection selection) async {
    await selectionBox.setValue(
      selection.id,
      selection.toJson(),
    );
  }

  Future<void> updateSelection(String id, Selection selection) async {
    await selectionBox.setValue(
      id,
      selection.toJson(),
    );
  }

  Selection getSelection(String id) {
    return Selection.fromJson(selectionBox.getValue(id));
  }

  Stream<List<Selection>> getAllSelections() {
    return selectionBox
        .listenValues()
        .map((list) => list.map((item) => Selection.fromJson(item)).toList());
  }
}
