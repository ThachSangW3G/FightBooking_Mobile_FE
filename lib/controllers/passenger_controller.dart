import 'package:get/get.dart';

class PassengerController extends GetxController {
  var adult = 0.obs;
  var children = 0.obs;
  var babe = 0.obs;

  void increaseAdult() {
    adult.value += 1;
  }

  void increaseChildren() {
    children.value += 1;
  }

  void increaseBabe() {
    babe.value += 1;
  }

  void reduceAdult() {
    if (adult.value > 0) {
      adult.value -= 1;
    }
  }

  void reduceChildren() {
    if (children.value > 0) {
      children.value -= 1;
    }
  }

  void reduceBabe() {
    if (babe.value > 0) {
      babe.value -= 1;
    }
  }
}
