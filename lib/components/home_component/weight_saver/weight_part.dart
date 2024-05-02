import 'package:flutter/material.dart';

class WeightPart extends StatefulWidget {
  const WeightPart({super.key});

  @override
  State<WeightPart> createState() => _WeightPartState();
}

class _WeightPartState extends State<WeightPart> {
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
  }

  void _addWeight() {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 30), // height: 300,
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                'Add Weight',
                style: TextStyle(fontSize: 18),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      suffixText: "KG",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    weightController.text;

                    Navigator.pop(context);
                  });
                },
                child: const Text('SAVE'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.scale,
            size: 29,
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pet's Weight",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                weightController.text.isEmpty? '0.00' :
                '${weightController.text} KG',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              _addWeight();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.deepPurple, //------->>DARK MODE--->>
              foregroundColor: Colors.white,
            ),
            child: const Text("+ Add"),
          ),
        ],
      ),
    );
  }
}
