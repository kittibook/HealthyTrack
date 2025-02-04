
import 'package:app/components/custom_textfield.dart';
import 'package:app/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Book1 extends StatefulWidget {
  const Book1({super.key});

  @override
  State<Book1> createState() => _Book1State();
}

class _Book1State extends State<Book1> {
  final _formKeybody = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bmiController = TextEditingController();
  final _pressureController = TextEditingController();
  final _sugarController = TextEditingController();
  final _fatController = TextEditingController();
  final _totalCholesterolController = TextEditingController();
  final _HDLController = TextEditingController();
  final _LDLController = TextEditingController();
  final _TrlglycerldesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'ติดตามสุขภาพด้วยตนเอง',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // ปิดคีย์บอร์ดเมื่อกดที่พื้นที่อื่น
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Center(
                  child: Form(
                    key: _formKeybody,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 50, 50, 50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "การตรวจร่างกาย",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ส่วนสูง(เซนติเมตร)",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller:
                                          _heightController, // ใช้ _heightController แทน
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: false,
                                      style: const TextStyle(
                                          color:
                                              Colors.white), // กำหนดสีข้อความ
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'ส่วนสูง',
                                        prefixIcon: const Icon(Icons.height),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true, // เปิดใช้งานพื้นหลัง
                                        fillColor:
                                            Colors.grey[600], // กำหนดสีพื้นหลัง
                                        isDense: true,
                                        prefixIconColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'ส่วนสูง(เซนติเมตร)';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        String w = value.replaceAll(
                                            RegExp(r'[^0-9.]'), '');
                                        setState(() {
                                          _heightController.text = w;
                                          if (_weightController
                                                  .text.isNotEmpty &&
                                              w.isNotEmpty) {
                                            double weight = double.tryParse(
                                                    _weightController.text) ??
                                                0;
                                            double height =
                                                double.tryParse(w) ?? 0;
                                            if (height > 0) {
                                              height = height /
                                                  100; // แปลงเซนติเมตรเป็นเมตร
                                              double bmi =
                                                  weight / (height * height) ;
                                              _bmiController.text =
                                                  bmi.toStringAsFixed(
                                                      2); // เก็บค่า BMI ลงใน Controller
                                            }
                                          }
                                        });
                                      },
                                    )
                                    // TEXTF(
                                    //   controller: _heightController,
                                    //   textInputType: TextInputType.number,
                                    //   hintText: 'ส่วนสูง(เซนติเมตร)',
                                    //   prefixIcon: const Icon(Icons.height),
                                    //   obscureText: false,
                                    //   inputFormatters: [
                                    //     FilteringTextInputFormatter.digitsOnly,
                                    //     LengthLimitingTextInputFormatter(3),
                                    //   ],
                                    //   validator: (value) {
                                    //     if (value == null || value.isEmpty) {
                                    //       return 'กรุณากรอกส่วนสูง(เซนติเมตร)';
                                    //     }
                                    //     return null;
                                    //   },
                                    // )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "น้ำหนัก(กิโลกรัม)",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller:
                                          _weightController, // ใช้ _heightController แทน
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: false,
                                      style: const TextStyle(
                                          color:
                                              Colors.white), // กำหนดสีข้อความ
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'น้ำหนัก',
                                        prefixIcon: const Icon(Icons.scale),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true, // เปิดใช้งานพื้นหลัง
                                        fillColor:
                                            Colors.grey[600], // กำหนดสีพื้นหลัง
                                        isDense: true,
                                        prefixIconColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'น้ำหนัก(กิโลกรัม)';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        String w = value.replaceAll(
                                            RegExp(r'[^0-9.]'), '');
                                        setState(() {
                                          _weightController.text = w;
                                          if (_heightController
                                                  .text.isNotEmpty &&
                                              w.isNotEmpty) {
                                            double height = double.tryParse(
                                                    _heightController.text) ??
                                                0;
                                            double weight =
                                                double.tryParse(w) ?? 0;
                                            if (height > 0) {
                                              height = height /
                                                  100; // แปลงเซนติเมตรเป็นเมตร
                                              double bmi =
                                                  weight / (height * height) ;
                                              _bmiController.text =
                                                  bmi.toStringAsFixed(
                                                      2); // เก็บค่า BMI ลงใน Controller
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    // TEXTF(
                                    //   controller: _weightController,
                                    //   textInputType: TextInputType.number,
                                    //   hintText: 'น้ำหนัก(กิโลกรัม)',
                                    //   prefixIcon: const Icon(Icons.scale),
                                    //   obscureText: false,
                                    //   inputFormatters: [
                                    //     FilteringTextInputFormatter.digitsOnly,
                                    //     LengthLimitingTextInputFormatter(3),
                                    //   ],
                                    //   validator: (value) {
                                    //     if (value == null || value.isEmpty) {
                                    //       return 'กรุณากรอกน้ำหนัก(กิโลกรัม)';
                                    //     }
                                    //     return null;
                                    //   },
                                    //   onChanged: (value) {
                                    //     String w = value.replaceAll(
                                    //         RegExp(r'[^0-9.]'), '');
                                    //     setState(() {
                                    //       _heightController.text = w;
                                    //       if (_weightController
                                    //               .text.isNotEmpty &&
                                    //           w.isNotEmpty) {
                                    //         double weight = double.tryParse(
                                    //                 _weightController.text) ??
                                    //             0;
                                    //         double height =
                                    //             double.tryParse(w) ?? 0;
                                    //         if (height > 0) {
                                    //           height = height /
                                    //               100; // แปลงเซนติเมตรเป็นเมตร
                                    //           double bmi =
                                    //               weight / (height * height);
                                    //           _bmiController.text =
                                    //               bmi.toStringAsFixed(
                                    //                   2); // เก็บค่า BMI ลงใน Controller
                                    //         }
                                    //       }
                                    //     });
                                    //    }
                                    // )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "BMI",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _bmiController,
                                      textInputType: TextInputType.number,
                                      hintText: 'BMI',
                                      prefixIcon:
                                          const Icon(Icons.monitor_weight),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกBMI';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 50, 50, 50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "ผลการตรวจ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ระดับความดัน",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _pressureController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ระดับความดัน',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกระดับความดัน';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ระดับน้ำตาล",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _sugarController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ระดับน้ำตาล',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกระดับน้ำตาล';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ละดับไขมันในกระแสเลือด TotalCholesterol",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _totalCholesterolController,
                                      textInputType: TextInputType.number,
                                      hintText:
                                          'ละดับไขมันในกระแสเลือด TotalCholesterol',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกละดับไขมันในกระแสเลือด TotalCholesterol';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ละดับไขมันในกระแสเลือด HDL",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _HDLController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ละดับไขมันในกระแสเลือด HDL',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกละดับไขมันในกระแสเลือด HDL';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ละดับไขมันในกระแสเลือด LDL",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _LDLController,
                                      textInputType: TextInputType.number,
                                      hintText: 'ละดับไขมันในกระแสเลือด LDL',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกละดับไขมันในกระแสเลือด LDL';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ละดับไขมันในกระแสเลือด Triglyceride",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 171, 171),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TEXTF(
                                      controller: _TrlglycerldesController,
                                      textInputType: TextInputType.number,
                                      hintText:
                                          'ละดับไขมันในกระแสเลือด Triglyceride',
                                      prefixIcon:
                                          const Icon(Icons.edit_document),
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกละดับไขมันในกระแสเลือด Triglyceride';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: RoundedButton(
                                    label: 'ยืนยัน',
                                    onPressed: () async {
                                      if (_formKeybody.currentState!
                                          .validate()) {
                                        // ถ้าข้อมูลผ่านการตรวจสอบ ให้ทำการบันทึกข้อมูล
                                        _formKeybody.currentState!.save();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
