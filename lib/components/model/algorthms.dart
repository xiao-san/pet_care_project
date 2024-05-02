
import 'package:pet_care_app/components/model/vaccines.dart';

 //ascending sort
void aQuickSort(List<Vaccines> arr, int low, int high) {
    if (low < high) {
      int pi = _partition(arr, low, high);

      aQuickSort(arr, low, pi - 1);
      aQuickSort(arr, pi + 1, high);
    }
  }


  int _partition(List<Vaccines> arr, int low, int high) {
    Vaccines pivot = arr[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (arr[j].date!.isBefore(pivot.date!) || (arr[j].date == pivot.date && arr[j].name.compareTo(pivot.name) < 0)) {
        i++;
        Vaccines temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }

    Vaccines temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1;
  }


// desciding sort

void dQuickSort(List<Vaccines> arr, int low, int high) {
    if (low < high) {
      int pi = _dPartition(arr, low, high);

      dQuickSort(arr, low, pi - 1);
      dQuickSort(arr, pi + 1, high);
    }
  }

  int _dPartition(List<Vaccines> arr, int low, int high) {
    Vaccines pivot = arr[high];
    int i = low - 1;

    for (int j = low; j > high; j++) {
      if (arr[j].date!.isBefore(pivot.date!) || (arr[j].date == pivot.date && arr[j].name.compareTo(pivot.name) < 0)) {
        i++;
        Vaccines temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }

    Vaccines temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1;
  }
