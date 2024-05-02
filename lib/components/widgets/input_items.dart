import 'package:flutter/material.dart';
import 'package:pet_care_app/components/model/vaccines.dart';
import 'package:pet_care_app/utils/my_utils.dart';
// import 'package:http/http.dart' as http;

class InputItems extends StatefulWidget {
  const InputItems(this.inputData, {super.key,});
  final Vaccines inputData;

  @override
  State<InputItems> createState() => _InputItemsState();
}

class _InputItemsState extends State<InputItems> {

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.blue,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Text(
              widget.inputData.name,
              style: MyUtils.body,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(widget.inputData.formattedDate),
                const Spacer(),
                Text(widget.inputData.formattedTime),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.inputData.note),
          ],
        ),
      ),
    );
  }
}
