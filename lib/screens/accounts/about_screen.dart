import 'package:flightbooking_mobile_fe/constants/app_border.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/user_controller.dart';
import 'package:flightbooking_mobile_fe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController personalIDController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dayOfBirthController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserController userController = Get.put(UserController());

  DateTime? dayOfBirth;

  String? valueGender;

  User? currentUser;

  bool _isLoading = false;

  Future<void> changeInfor() async {
    final fullName = fullNameController.text;
    final phoneNumber = phoneNumberController.text;
    final address = addressController.text;
    final personalId = personalIDController.text;

    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        address.isEmpty ||
        personalId.isEmpty ||
        dayOfBirth == null ||
        valueGender == null) {
      final snackdemo = SnackBar(
        content: Text(
          'Vui lòng điền đầy đủ thông tin!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);

      return;
    }

    final prefs = await _prefs;

    final token = prefs.getString('tokenAccess');
    setState(() {
      _isLoading = true;
    });

    final success = await userController.changeInfor(
        token!,
        fullName,
        dayOfBirth!.toIso8601String(),
        valueGender!,
        address,
        phoneNumber,
        personalId);

    if (success) {
      final snackdemo = SnackBar(
        content: Text(
          'Cập nhật thông tin thành công!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      // Đăng nhập thất bại, hiển thị thông báo cho người dùng
      final snackdemo = SnackBar(
        content: Text(
          'Cập nhật thông tin không thành công!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }

    setState(() {
      _isLoading = false;
    });
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  void getUserByToken() async {
    currentUser = userController.currentUser.value;

    print(currentUser!.dayOfBirth);

    setState(() {
      if (currentUser != null) {
        if (currentUser!.fullName != null) {
          fullNameController.text = currentUser!.fullName!;
        }

        if (currentUser!.email != null) {
          emailController.text = currentUser!.email!;
        }

        if (currentUser!.phoneNumber != "string") {
          phoneNumberController.text = currentUser!.phoneNumber!;
        }

        if (currentUser!.address != "string") {
          addressController.text = currentUser!.address!;
        }

        if (currentUser!.gender != "string") {
          genderController.text = currentUser!.gender!;
          valueGender = currentUser!.gender!;
        }

        if (currentUser!.personalId != "string") {
          personalIDController.text = currentUser!.personalId!;
        }

        if (currentUser!.dayOfBirth != null) {
          dayOfBirthController.text = formatDate(currentUser!.dayOfBirth!);
          dayOfBirth = currentUser!.dayOfBirth!;
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserByToken();
  }

  var itemsGender = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisper,
      appBar: AppBar(
        title: Text(
          'About me',
          style: kLableTextBlackW600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Personal Details',
                  style: kLableTilteBlack,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: fullNameController,
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        hintText: 'Full name',
                        hintStyle: kLableTextBlackMinium,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/person.svg',
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: emailController,
                    readOnly: true,
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: kLableTextBlackMinium,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/mail.svg',
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: phoneNumberController,
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: kLableTextBlackMinium,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/phone.svg',
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: addressController,
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: kLableTextBlackMinium,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/phone.svg',
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: personalIDController,
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        hintText: 'Personal ID',
                        hintStyle: kLableTextBlackMinium,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/phone.svg',
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/phone.svg',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text(
                            'Choose your gender',
                            style: kLableTextBlackMinium,
                          ),
                          items: itemsGender.map((String e) {
                            return DropdownMenuItem(
                              child: Text(
                                e,
                                style: kLableTextBlackMinium,
                              ),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              valueGender = newValue!;
                            });
                          },
                          value: valueGender,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: TextFormField(
                      controller: dayOfBirthController,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'dd/MM/yyyy',
                          hintStyle: kLableTextBlackMinium,
                          suffixIcon: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2026))
                                    .then((value) {
                                  setState(() {
                                    dayOfBirth = value!;
                                    dayOfBirthController.text =
                                        formatDate(dayOfBirth!);
                                  });
                                });
                              },
                              child: const Icon(Icons.calendar_month)),
                          contentPadding: borderRadiusTextField,
                          focusedBorder: borderTextFieldFocus,
                          border: InputBorder.none),
                    ))
              ]),
              Positioned(
                  bottom: 140,
                  child: InkWell(
                    onTap: changeInfor,
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: const BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              )
                            : Text(
                                'Save settings',
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
