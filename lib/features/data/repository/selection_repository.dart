import 'dart:convert';

import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/box_helper.dart';
import 'package:rxdart/rxdart.dart';

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
    final result = selectionBox.getValue(id);
    final decodedResult = json.decode(json.encode(result));

    return result != null
        ? Selection.fromJson(decodedResult)
        : Selection.empty();
  }

  Stream<List<Selection>> getAllSelections() {
    return selectionBox
        .listenValues()
        .map((list) => list
            .map(
              (item) => Selection.fromJson(
                json.decode(json.encode(item)),
              ),
            )
            .toList())
        .startWith(
          selectionBox
              .getValues()
              .map(
                (item) => Selection.fromJson(
                  json.decode(json.encode(item)),
                ),
              )
              .toList(),
        );
  }
}
