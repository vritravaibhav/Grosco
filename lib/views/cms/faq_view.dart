import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:rohit_multivender/utills/app_colors.dart';
import 'package:http/http.dart' as http;

class FaqView extends StatefulWidget {
  const FaqView({super.key});

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  String ques = "product";
  String ans = "Good product";

  Future<void> getData() async {
    http.Response res = await http.get(Uri.parse("localhost:4000/api/v1/faq"));
    if (res.statusCode == 200) {
      ques = jsonDecode(res.body)["question"];
      ans = jsonDecode(res.body)["answer"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final sentence = Lorem.sentence(numSentences: 30);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.ktextColor,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          "FAQ’s",
          style: TextStyle(color: AppColors.ktextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            ques,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.ktextColor),
          ),
          Text(
            ans,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.ktextColor),
          ),
        ]),
      ))),
    );
  }
}
