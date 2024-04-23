import 'package:flightbooking_mobile_fe/models/sort.dart';
import 'package:get/get.dart';

class SortController extends GetxController {
  var sorts = const [
    Sort(id: 1, title: 'Giá thấp nhất'),
    Sort(id: 2, title: 'Cất cánh sớm nhất'),
    Sort(id: 3, title: 'Cất cánh muộn nhất'),
    Sort(id: 4, title: 'Hạ cánh sớm nhất'),
    Sort(id: 5, title: 'Hạ cánh muộn nhất'),
    Sort(id: 6, title: 'Thời gian bay ngắn nhất'),
  ];

  var selectedSort = 1.obs;

  void setSelectedSort(int index) {
    selectedSort.value = index;
  }
}
