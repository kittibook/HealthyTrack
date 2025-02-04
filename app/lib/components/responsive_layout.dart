import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webChild;
  final Widget mobileChild;

  const ResponsiveLayout(
      {super.key, required this.webChild, required this.mobileChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // ปิดคีย์บอร์ดเมื่อกดที่พื้นที่อื่น
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.grey[800],
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // ทำ ResponsiveLayout
                    child: LayoutBuilder(
                        builder: (
                          BuildContext context,
                          BoxConstraints constraints,
                        ){
                          Widget childwiget = mobileChild;
                          if(constraints.maxWidth > 800){
                            childwiget = webChild;
                          }
                          return childwiget;
                        },
                      ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
