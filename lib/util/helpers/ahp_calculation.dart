class AHPCalculation<T> {
  final List<T> list;

  AHPCalculation({
    required this.list,
  });

  int get length => list.length;

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

  List<double> get priority {
    final List<double> temp = [];

    for (int i = 0; i < totalSecondMatrix.length; i++) {
      temp.add(totalSecondMatrix[i] / length);
    }

    return temp;
  }
}
