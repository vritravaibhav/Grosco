import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rohit_multivender/utills/app_colors.dart';
import 'package:rohit_multivender/utills/constant_box.dart';
import 'package:rohit_multivender/utills/constant_button.dart';
import 'package:rohit_multivender/views/auth/otp_verification_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      kbox50(),
      Column(
        children: [
          Container(height: 150, child: Image.asset("assets/logo+glow.png")),
          const Text(
            "The Grocery company",
            style: TextStyle(
                color: AppColors.ktextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ],
      ),
      kbox50(),
      kbox30(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SIGN IN ",
                      style: TextStyle(
                          color: AppColors.ktextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                    kbox10(),
                    const Text(
                      "Mobile No :",
                      style: TextStyle(
                          color: AppColors.ktextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    kbox5(),
                    Container(
                      transform: Matrix4.identity()
                        ..setEntry(
                            3, 2, 0.001) // add perspective transformation
                        ..rotateX(0.2), //
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.ktextColor.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 5), // controls the shadow position
                            ),
                          ],
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width - 70,
                      child: IntlPhoneField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        dropdownTextStyle:
                            const TextStyle(color: AppColors.ktextColor),
                        showCountryFlag: true,
                        pickerDialogStyle: PickerDialogStyle(
                            countryNameStyle:
                                const TextStyle(color: AppColors.ktextColor)),
                        disableLengthCheck: true,
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorHeight: 30,
                        flagsButtonPadding: const EdgeInsets.only(top: 5),
                        //controller: controller.numberController,
                        style: const TextStyle(color: AppColors.ktextColor),
                        decoration: const InputDecoration(
                            // contentPadding: const EdgeInsets.only(top: 20),
                            alignLabelWithHint: false,
                            fillColor: Colors.red,
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ktextColor),
                            hintText: "9876543",
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppColors.ktextColor),
                            border: InputBorder.none),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          // phonenumber = phone.number;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kbox50(),
            kbox30(),
            kbox30(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kboxw10(),
                kbutton("Get OTP", () async {
                  http.Response res = await http.post(
                    Uri.parse("localhost:4000/api/v1/register"),
                    body: jsonEncode({
                      'mobileNumber': _phoneNumber.text,
                    }),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                  );

                  Get.to(OTPVerificationView(
                    mobileNumber: _phoneNumber.text,
                    otp: jsonDecode(res.body)["otp"],
                  ));
                }),
              ],
            )
          ],
        ),
      ),
    ])

        // Positioned(
        //   bottom: 0,
        //   child: SizedBox(
        //       width: Get.width,
        //       child: Image.asset(
        //         "assets/fruit2.png",
        //         fit: BoxFit.cover,
        //       )),
        // )

        );
  }
}
