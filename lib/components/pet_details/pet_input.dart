import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care_app/components/pet_details/question_lists.dart';
import 'package:http/http.dart' as http;

class PetInput extends StatefulWidget {
  const PetInput({super.key});

  @override
  State<PetInput> createState() => _PetInputState();
}

class _PetInputState extends State<PetInput> {
  var currentQuestionIndex = 0;
  List<String> answeredData = [];
  // List<Widget> imageList = [];

  //sendding data to firebase ->->->->->

  void validateData() async {
    final url = Uri.https(
        'petcareapp-95b81-default-rtdb.firebaseio.com', 'pet-details.json');
    final responds = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: json.encode({
          'pet_name': answeredData[0],
          'pet_type': answeredData[1],
          'pet_breed': answeredData[2],
        }));

    print(responds.body);
    print(responds.statusCode);
  }
  // // validation of the code
  // bool nameEntered = false; // pet's name
  // bool typeEntered = true; //pet's type (dog or cat)
  // bool breedEntered = true; //pet's breed

//changing question index--
  void changeQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
    //Return
  }

// Adding Answer to the asweredList--
  void addAnswers(String answer) {
    // print(selectedPetType); // Check if selectedPetType is printed correctly
    setState(() {
      if (currentQuestionIndex == 0) {
        answeredData.add(answer);
      } else if (currentQuestionIndex == 1) {
        print('Adding selectedPetType to answeredData: $selectedPetType');
        answeredData.add(selectedPetType);
      } else if (currentQuestionIndex == 2 && selectedPetType == "Cat") {
        answeredData.add(selectedCatBreed);
      } else if (currentQuestionIndex == 2 && selectedPetType == "Dog") {
        answeredData.add(selectedDogBreed);
      } else if (currentQuestionIndex == 3) {
        print('Upload an image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //getting the CurrentQuestion data as question[index] ---> (String, Widget)--->>>>>>>
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.question,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            currentQuestion.answerField,
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                //adding TextField controllerName Data to the addAnswers List--->
                String answer = controllerName.text;
                if (currentQuestionIndex == 0 && answer.isNotEmpty) {
                  addAnswers(answer);
                  changeQuestion();
                  print(answeredData);
                  print('data added');
                } else if (currentQuestionIndex == 1 &&
                    selectedPetType.isNotEmpty) {
                  addAnswers(selectedPetType);
                  changeQuestion();
                  print(answeredData);
                  print('added data');
                } else if (currentQuestionIndex == 2 &&
                    selectedCatBreed != "") {
                  addAnswers(selectedCatBreed);
                  addAnswers(selectedDogBreed);
                  changeQuestion();
                  print(answeredData);
                  validateData();
                  Navigator.pop(context);
                } else {
                  // Showing an error message by handlimg the validation error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter the required information."),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 131, 94, 195),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
