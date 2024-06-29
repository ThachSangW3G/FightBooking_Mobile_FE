import 'package:flightbooking_mobile_fe/models/Thuongle/seat_class.dart';
import 'package:get/get.dart';

class SeatClassController extends GetxController {
  var seatClasses = const [
    SeatClass(
        id: 1,
        title: 'Economy',
        desc: 'Bay đẳng cấp, với quầy làm thủ tục và khu ghế ngồi riêng'),
    SeatClass(
        id: 2,
        title: 'Premium',
        desc: 'Chi phí hợp lý với bữa ăn ngon và chỗ để chân rộng rãi'),
    SeatClass(
        id: 3,
        title: 'Business',
        desc: 'Bay tiết kiệm, đáp ứng mọi nhu cầu cơ bản của bạn'),
    SeatClass(
        id: 4,
        title: 'First class',
        desc: 'Hạng cao cấp nhất, với dịch vụ 5 sao được cá nhân hóa')
  ];

  var selectedSeatClass = 1.obs;

  void setSelectedSeatClass(int index) {
    selectedSeatClass.value = index;
  }
}
