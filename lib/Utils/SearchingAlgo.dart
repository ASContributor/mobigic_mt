List<List<int>> searchInGrid(
  String searchText, {
  required List<String> grid,
  required int rows,
  required int cols,
}) {
  List<List<String>> convertedGrid = convertToGrid(grid, rows, cols);

  List<List<int>> result = [];

  //  Horizontal Search
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j <= cols - searchText.length; j++) {
      String word = convertedGrid[i].sublist(j, j + searchText.length).join();
      if (word == searchText) {
        List<int> path = [];
        for (int k = j; k < j + searchText.length; k++) {
          path.add(i);
          path.add(k);
        }
        result.add(path);
      }
    }
  }

  //  Vertical Search
  for (int i = 0; i <= rows - searchText.length; i++) {
    for (int j = 0; j < cols; j++) {
      String word = '';
      for (int k = i; k < i + searchText.length; k++) {
        word += convertedGrid[k][j];
      }
      if (word == searchText) {
        List<int> path = [];
        for (int k = i; k < i + searchText.length; k++) {
          path.add(k);
          path.add(j);
        }
        result.add(path);
      }
    }
  }

  //  Diagonal Search (from top-left to bottom-right)
  for (int i = 0; i <= rows - searchText.length; i++) {
    for (int j = 0; j <= cols - searchText.length; j++) {
      String word = '';
      for (int k = 0; k < searchText.length; k++) {
        word += convertedGrid[i + k][j + k];
      }
      if (word == searchText) {
        List<int> path = [];
        for (int k = 0; k < searchText.length; k++) {
          path.add(i + k);
          path.add(j + k);
        }
        result.add(path);
      }
    }
  }

  return result;
}

List<List<String>> convertToGrid(List<String> list, int rows, int cols) {
  List<List<String>> grid = [];
  for (int i = 0; i < rows; i++) {
    grid.add(list.sublist(i * cols, (i + 1) * cols));
  }
  return grid;
}
