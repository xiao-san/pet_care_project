import 'package:flutter/material.dart';
import 'package:pet_care_app/components/pet_details/model/questions.dart';
import 'package:pet_care_app/components/pet_details/question_lists.dart';


class BreedSelectionWidget extends StatefulWidget {
  const BreedSelectionWidget({super.key});

  @override
  State<BreedSelectionWidget> createState() => _BreedSelectionWidgetState();
}

class _BreedSelectionWidgetState extends State<BreedSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return selectedPetType == "Dog"
        ? SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              value: selectedDogBreed, // initially selected value
              hint: const Text('Select Dog Breed'),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Select Dog Breed',
                fillColor: Colors.blue,
              ),
              items: dogBreeds
                  .map((breed) => DropdownMenuItem<String>(
                        value: breed,
                        child: Text(breed),
                      ))
                  .toList(),
              onChanged: (selectedBreed) {
                selectedDogBreed = selectedBreed!;
                print(selectedDogBreed);
              },
            ),
          )
        : SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              value: selectedCatBreed, // initially selected value
              hint: const Text('Select Cat Breed'),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                // hintText: 'Cat Breeds'
                labelText: 'Select cat breeds',
                fillColor: Colors.blue,
              ),
              items: catBreeds
                  .map((breed) => DropdownMenuItem<String>(
                        value: breed,
                        child: Text(breed),
                      ))
                  .toList(),
              onChanged: (selectedBreed) {
                selectedCatBreed = selectedBreed!;
                print(selectedCatBreed);
              },
            ),
          );
  }
}