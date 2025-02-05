import 'package:flutter/material.dart';

class Book11 extends StatefulWidget {
  const Book11({super.key});

  @override
  State<Book11> createState() => _Book11State();
}

class _Book11State extends State<Book11> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final color = {
      'ปกติ': Colors.white,
      'เสี่ยง': Colors.green,
      'ป่วยระดับ 0': Colors.green[800],
      'ป่วยระดับ 1': Colors.yellow,
      'ป่วยระดับ 2': Colors.orange,
      'ป่วยระดับ 3': Colors.red,
      'กลุ่มผู้ป่วยที่มีโรคแทรกซ้อน': Colors.blueGrey[700]
    };
    final pressure = arguments['data']['pressure']['title'];
    final pressuretext = arguments['data']['pressure']['text'];
    final fattexttitle = arguments['data']['fat']['title'];
    final fattext = arguments['data']['fat']['text'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'ติดตามสุขภาพด้วยตนเอง',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // ทำให้ข้อความอยู่กลาง
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: const Color.fromARGB(255, 50, 50, 50),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
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
                                  Center(
                                    child: Text(
                                      "ผลการตรวจอยู่ในเกณฑ์ $pressure",
                                      style: TextStyle(
                                        color: color[pressure],
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ]),
                          ),
                        ),
                        const SizedBox(height: 50),
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
                                  Center(
                                    child: Text(
                                      "$pressuretext",
                                      style: TextStyle(
                                        color: color[pressure],
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                ]),
                          ),
                        ),

                        const SizedBox(height: 50),
                        if (fattext != null && fattext.isNotEmpty)
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
                                  Center(
                                    child: Text(
                                      "$fattext",
                                      style: TextStyle(
                                        color: color[pressure],
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
