import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// customTextField เป็น widget ที่เราสร้างขึ้นมาเอง
// โดยมีการรับค่าต่างๆ มาจากภายนอก
// และส่งค่าต่างๆ กลับไปยังภายนอก
Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  required Icon prefixIcon,
  required bool obscureText,
  TextInputType textInputType = TextInputType.text,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    autofocus: false,
    enableSuggestions: false,
    autocorrect: false,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      filled: true,
      isDense: true,
      prefixIconColor: Colors.black,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      fillColor: Colors.grey[300],
    ),
    validator: validator,
  );
}

Widget TEXTF({
  required TextEditingController controller,
  required String hintText,
  required Icon prefixIcon,
  required bool obscureText,
  required TextInputType textInputType,
  required List<TextInputFormatter> inputFormatters, // เปลี่ยนเป็น List
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    autofocus: false,
    enableSuggestions: false,
    autocorrect: false,
    obscureText: obscureText,
    style: const TextStyle(color: Colors.white), // กำหนดสีข้อความ
    decoration: InputDecoration(
      hintStyle: TextStyle(color: Colors.white),
      hintText: hintText,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      filled: true, // เปิดใช้งานพื้นหลัง
      fillColor: Colors.grey[600], // กำหนดสีพื้นหลัง
      isDense: true,
      prefixIconColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    ),
    inputFormatters: inputFormatters, // ใช้เป็น List
    validator: validator,
  );
}
