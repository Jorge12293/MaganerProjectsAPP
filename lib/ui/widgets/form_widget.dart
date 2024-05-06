import 'package:flutter/material.dart';

InputDecoration inputDecoration({String? hintText,String? labelText,Widget? suffixIcon}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle:const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
    ),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(),
    ),
  );
}

InputDecoration inputDecorationPassword({String? hintText,String? labelText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle:const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(),
    ),
  );
}


SizedBox sizedBoxHeightSmall(){
  return const SizedBox(height: 10);
}
SizedBox sizedBoxHeightMedium(){
  return const SizedBox(height: 20);
}