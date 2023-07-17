import 'package:sekrut/features/domain/models/intensity.dart';

const Map<int, double> indexRandom = {
  1: 0.00,
  2: 0.00,
  3: 0.58,
  4: 0.90,
  5: 1.12,
  6: 1.24,
  7: 1.32,
  8: 1.41,
  9: 1.45,
  10: 1.49,
  11: 1.51,
  12: 1.48,
  13: 1.56,
  14: 1.57,
  15: 1.59,
};

class AHPCalculation<T> {
  final List<T> list;
  final Map<String, List<IntensityValue>> intensities;

  AHPCalculation({
    required this.list,
    this.intensities = const {},
  });

  int get length => list.length;

  int get lengthAlt => intensities.length;

  Map<String, Map<String, dynamic>> get firstMatrixAlt {
    final Map<String, Map<String, dynamic>> matrix = {};

    for (int i = 0; i < lengthAlt; i++) {
      Map<String, dynamic> temp = {};

      for (int j = 0; j < lengthAlt; j++) {
        temp[intensities.keys.toList()[j]] =
            intensities.values.toList()[i][j].value;
      }

      matrix[intensities.keys.toList()[i]] = temp;
    }

    return matrix;
  }

  Map<String, double> get totalFirstMatrixAlt {
    final Map<String, double> temp = {};

    firstMatrixAlt.forEach((key, value) {
      value.forEach((subKey, subValue) {
        temp[subKey] = (temp[subKey] ?? 0) + subValue;
      });
    });

    return temp;
  }

  Map<String, Map<String, dynamic>> get secondMatrixAlt {
    final Map<String, Map<String, dynamic>> matrix = {};

    for (int i = 0; i < firstMatrixAlt.length; i++) {
      Map<String, dynamic> temp = {};

      for (int j = 0; j < firstMatrixAlt.length; j++) {
        temp[firstMatrixAlt.keys.toList()[j]] =
            firstMatrixAlt[firstMatrixAlt.keys.toList()[i]]
                    ?[firstMatrixAlt.keys.toList()[j]] /
                totalFirstMatrixAlt[totalFirstMatrixAlt.keys.toList()[j]];
      }

      matrix[firstMatrixAlt.keys.toList()[i]] = temp;
    }

    return matrix;
  }

  Map<String, double> get totalSecondMatrixAlt {
    final Map<String, double> temp = {};

    secondMatrixAlt.forEach((key, value) {
      double tempValue = 0;

      value.forEach((subKey, subValue) {
        tempValue += subValue;
      });

      temp[key] = tempValue;
    });

    return temp;
  }

  Map<String, double> get prioritiesAlt {
    final Map<String, double> temp = {};

    totalSecondMatrixAlt.forEach((key, value) {
      temp[key] = value / lengthAlt;
    });

    return temp;
  }

  List<List<double>> get firstMatrix {
    final List<List<double>> matrix = [];

    for (int i = 0; i < length; i++) {
      List<double> temp = [];

      for (int j = 0; j < length; j++) {
        final iteratePoint = j + 1;
        final starterPoint = i + 1;
        final space = iteratePoint - starterPoint;
        final double value = space >= 0 ? space + 1 : 1 / (space.abs() + 1);

        temp.add(value);
      }

      matrix.add(temp);
    }

    return matrix;
  }

  List<double> get totalFirstMatrix {
    final List<double> total = [];

    for (int i = 0; i < firstMatrix.length; i++) {
      double temp = 0;

      for (int j = 0; j < firstMatrix.length; j++) {
        temp += firstMatrix[j][i];
      }

      total.add(temp);
    }

    return total;
  }

  List<List<double>> get secondMatrix {
    final List<List<double>> matrix = [];

    for (int i = 0; i < firstMatrix.length; i++) {
      List<double> temp = [];

      for (int j = 0; j < firstMatrix.length; j++) {
        final double value = firstMatrix[i][j] / totalFirstMatrix[j];

        temp.add(value);
      }

      matrix.add(temp);
    }

    return matrix;
  }

  List<double> get totalSecondMatrix {
    final List<double> total = [];

    for (int i = 0; i < secondMatrix.length; i++) {
      double temp = 0;

      for (int j = 0; j < secondMatrix.length; j++) {
        temp += secondMatrix[i][j];
      }

      total.add(temp);
    }

    return total;
  }

  List<double> get priorities {
    final List<double> temp = [];

    for (int i = 0; i < totalSecondMatrix.length; i++) {
      temp.add(totalSecondMatrix[i] / length);
    }

    return temp;
  }

  double getPriority(T data) {
    final foundIndex = list.indexOf(data);

    return priorities[foundIndex];
  }

  double getPriorityAlt(String key) {
    return prioritiesAlt[key] ?? 0;
  }

  double get lambdaMax {
    double temp = 0;

    for (int i = 0; i < priorities.length; i++) {
      temp += priorities[i] * totalFirstMatrix[i];
    }

    return temp;
  }

  double get lambdaMaxAlt {
    double temp = 0;
    final prioAlt = prioritiesAlt;
    final totalFirst = totalFirstMatrixAlt;

    for (MapEntry<String, double> entry in prioAlt.entries) {
      temp += (prioritiesAlt[entry.key] ?? 0) *
          (totalFirstMatrixAlt[entry.key] ?? 0);
    }

    return temp;
  }

  double get consistencyRate {
    final ci = (lambdaMaxAlt - lengthAlt) / (lengthAlt - 1);
    final cr = ci / (indexRandom[lengthAlt] ?? 0);

    return cr;
  }

  bool get isConsistenceAlt => consistencyRate < 0.1;

  bool get isConcistence {
    final ci = (lambdaMax - length) / (length - 1);
    final cr = ci / (indexRandom[length] ?? 0);

    return cr < 0.1;
  }
}
