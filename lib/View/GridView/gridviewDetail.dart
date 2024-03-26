import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:mobigic_mt/Utils/SearchingAlgo.dart';
import 'package:mobigic_mt/View/Input_screen/InputBloc/input_bloc.dart';
import 'package:alert_dialog/alert_dialog.dart';

class GridviewDetail extends StatefulWidget {
  const GridviewDetail({
    super.key,
    required this.inputBloc,
  });
  final InputBloc inputBloc;
  @override
  State<GridviewDetail> createState() => _GridviewDetailState();
}

class _GridviewDetailState extends State<GridviewDetail> {
  final TextEditingController _searchController = TextEditingController();
  List<int> searchResults = [];
  int col = 0;
  int row = 0;

  @override
  void initState() {
    // TODO: implement initState
    col = int.parse(widget.inputBloc.colController.text);
    row = int.parse(widget.inputBloc.rowController.text);
    super.initState();
  }

  void _updateSearchResults(List<List<int>> searchResults) {
    List<int> indices = [];
    for (var result in searchResults) {
      print(result.length);
      for (int i = 0; i < result.length; i += 2) {
        int x = result[i];
        int y = result[i + 1];
        int index = x * col + y;

        indices.add(index);
      }
    }
    setState(() {
      print(indices);
      this.searchResults = indices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              searchField(context),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GridView.builder(
                      itemCount: col * row,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: row == 0 ? 1.0 : row.toDouble(),
                          crossAxisCount: col == 0 ? 1 : col),
                      itemBuilder: itemDetails)),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: 'Search'),
          ),
        ),
        FilledButton(
            onPressed: () {
              List<List<int>> searchResults = searchInGrid(
                  _searchController.text,
                  grid: widget.inputBloc.gridList,
                  cols: col,
                  rows: row);
              if (searchResults.isNotEmpty) {
                _updateSearchResults(searchResults);
                print(
                    'Search text found at the following indices: $searchResults');
              } else {
                alert(context,
                    title: const Text(
                      'Search text not found in the grid.',
                      style: TextStyle(fontSize: 15),
                    ));
                print('Search text not found in the grid.');
              }
            },
            child: const Text('Search'))
      ],
    );
  }

  Widget? itemDetails(context, index) {
    int rowIndex = index ~/ col;
    int colIndex = index % col;
    final updateController = TextEditingController();
    bool isHighlighted = searchResults.contains(index);
    return GestureDetector(
      onTap: () {
        Dialogs.materialDialog(
            msg: 'Current Number : ${widget.inputBloc.gridList[index]}',
            title: "Update Element",
            color: Colors.white,
            context: context,
            actions: [
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                ],
                maxLength: 1,
                controller: updateController,
              ),
              FilledButton(
                  onPressed: () {
                    widget.inputBloc.add(UpdateElementbyIndexEvent(
                        Index: index, Value: updateController.text));
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Update'))
            ]);
      },
      child: Card(
        color: isHighlighted
            ? const Color.fromARGB(255, 251, 237, 108)
            : Color.fromARGB(255, 236, 232, 244),
        child: Center(
          child: Text(
            index >= widget.inputBloc.gridList.length
                ? ""
                : widget.inputBloc.gridList[index],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
