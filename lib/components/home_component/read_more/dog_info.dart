import 'package:flutter/material.dart';

class DogInfo extends StatefulWidget {
  const DogInfo({super.key});

  @override
  State<DogInfo> createState() => _DogInfoState();
}

class _DogInfoState extends State<DogInfo> {
  List<String> dogName = [
    'Labrador Retriever',
    'German Shepherd',
    'Golden Retriever',
    'Pug',
    'Poodle'
  ];
  List<String> infoName = [
    'Dog Name :',
    'Height :',
    'Weight :',
    'Lifespan: ',
  ];

  List<String> dogHeight = [
    '22 - 25 inch',
    '24 - 26 inch',
    '22 - 24 inch',
    '11 - 13 inch',
    '11 - 15 inch',
  ];

  List<String> dogWeight = [
    '25 - 25 kg',
    '20 - 40kg',
    '25 - 34 kg',
    '6.4 - 8.1 kg',
    '15 - 32 kg',
  ];

  List<String> dogLifeSpan = [
    '10 - 13 years',
    '9 - 13 years',
    '10 - 12 years',
    '12 - 15 years',
    '12 - 15 years',
  ];

  List<String> doInfo = [
    "This dog's breed falls under the sporting group. These dog are playful and active.",
    "This dog's breed falls under the sporting group. These dog are the most loyal & intelligent.These dogs are used for search and rescue operation.",
    "Labrador Retrievers are very well-mannered and loyal. Their pleasing and attractive looks make everyone fall in love with these dogs. They are easy to train.",
    "Pugs fall under the Toy Group. Due to its cute size and adorable structure, this dog breed is most suitable for small households and apartments. They are very playful, active, and outgoing dogs.",
    "This dog breed falls under the category of Non-Sporting Group. This breed of dog is known to be highly intelligent, graceful, and friendly. Their slim muscled bodies make them easy to run quickly. "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
                    scrollDirection: Axis.horizontal,
            itemCount: dogName.length,
            itemBuilder: (ctx, index) => Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            infoName[0],
                            style: headerStyle(),
                          ),
                          Text(
                            dogName[index],
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            infoName[1],
                            style: midStyle(),
                          ),
                          Text(
                            dogHeight[index],
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            infoName[2],
                            style: midStyle(),
                          ),
                          Text(
                            dogWeight[index],
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            infoName[3],
                            style: midStyle(),
                          ),
                          Text(
                            dogLifeSpan[index],
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            doInfo[index],
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )));
  }

  TextStyle bodyStyle() {
    return TextStyle(
      fontFamily: AutofillHints.telephoneNumberLocalPrefix,
      fontSize: 18,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle midStyle() {
    return TextStyle(
      fontFamily: AutofillHints.telephoneNumberLocalPrefix,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle headerStyle() {
    return TextStyle(
      fontFamily: AutofillHints.telephoneNumberLocalPrefix,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}
