import 'package:flutter/material.dart';
import 'package:pet_care_app/components/model/algorthms.dart';
import 'package:pet_care_app/components/model/vaccines.dart';
import 'package:pet_care_app/components/widgets/input_items.dart';
import 'package:http/http.dart' as http;

class InputFieldList extends StatefulWidget {
  const InputFieldList({super.key, required this.inputData});
  final List<Vaccines> inputData;

  @override
  State<InputFieldList> createState() => _InputFieldListState();
}

class _InputFieldListState extends State<InputFieldList> {
  List<Vaccines> _filteredData = [];
  bool _isAscending = true;

  @override
  void initState() {
    _filteredData = List.from(widget.inputData);
    super.initState();
  }

  void sortByDate(bool ascending) {
    setState(() {
      _isAscending = ascending;
      if (ascending) {
        aQuickSort(_filteredData, 0, _filteredData.length - 1);
      } else {
        dQuickSort(_filteredData, 0, _filteredData.length - 1);
      }
    });
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = widget.inputData
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _deletedData(Vaccines data) async {
    final url = Uri.https('petcareapp-95b81-default-rtdb.firebaseio.com',
        'schedule-data/${data.id}.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Vaccine deleted successfully...');
      setState(() {
        widget.inputData.removeWhere((item) => item.id == data.id);
        _filteredData.removeWhere((item) => item.id == data.id);
      });
    } else {
      print('Error deleting vaccine: ${response.statusCode}');
      // Handle deletion error (optional)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(6.0),
          color: Colors.white,
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged: _filterData,
            decoration: InputDecoration(
              labelText: 'Search by name',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: PopupMenuButton(
                itemBuilder: (BuildContext context) => const[
                  PopupMenuItem(
                    child: Text('Sort by Date (Ascending)'),
                    value: true,
                  ),
                  PopupMenuItem(
                    child: Text('Sort by Date (Descending)'),
                    value: false,
                  ),
                ],
                onSelected: (value) {
                  sortByDate(value as bool);
                },
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredData.length,
            itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete_forever,
                    color: Colors.white, size: 28),
              ),
              direction: DismissDirection.endToStart,
              key: ValueKey(_filteredData[index]),
              onDismissed: (direction) => _deletedData(_filteredData[index]),
              child: InputItems(_filteredData[index]),
            ),
          ),
        ),
      ],
    );
  }
}
