import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:rohit_multivender/utills/app_colors.dart';
import 'package:http/http.dart' as http;

class TermAndConditionView extends StatefulWidget {
  const TermAndConditionView({super.key});

  @override
  State<TermAndConditionView> createState() => _TermAndConditionViewState();
}

class _TermAndConditionViewState extends State<TermAndConditionView> {
  // bool idLoading = false;
  String sentence = Lorem.sentence(numSentences: 30);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTerms();
  }

  Future<void> getTerms() async {
    http.Response res =
        await http.get(Uri.parse("localhost:4000/api/v1/terms"));
    if (res.statusCode == 200) {
      sentence = jsonDecode(res.body)["terms"]["terms"];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          "Terms & Condition",
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
            sentence,
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
