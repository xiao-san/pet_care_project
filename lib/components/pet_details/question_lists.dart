// Questions and Answers Model ----->
import 'package:flutter/material.dart';
import 'package:pet_care_app/components/pet_details/model/breed_selection_widget.dart';
import 'package:pet_care_app/components/pet_details/model/questions.dart';


final TextEditingController controllerName = TextEditingController();
String selectedDogBreed = "Bulldog";
String selectedCatBreed = "Abyssinian";
String selectedPetType = "";

void selectedPet(String petType) {
  //Type define gareko xaina vane mathi kai global variable lido raixa ----> Note
  selectedPetType = petType;
  print('Selected Pet Type: $selectedPetType');
}

final questions = [
  //First Question For TextField
  Questions(
    "What is your pet's name",
    SizedBox(
      width: 180,
      child: TextField(
        controller: controllerName,
        decoration: InputDecoration(
            hintText: "Enter pet's name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    ),
  ),

  //Second Question for Dog or Cat Selector
  Questions(
    "What is your Pet Type",
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Dog Section
        GestureDetector(
          onTap: () {
            String petType = "Dog";
            selectedPet(petType);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('images/intro_images/4.png'),
          ),
        ),

        //Cat Sector
        GestureDetector(
          onTap: () {
            String petType = "Cat";
            selectedPet(petType);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('images/intro_images/5.png'),
          ),
        ),
      ],
    ),
  ),

  Questions(
    "Pet Breed Selection",
    const BreedSelectionWidget(),
  ),

];
