import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/screens/all_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFEFEEF2),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Group 7.svg",
            color: Color(0XFF7C66E9),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllTaskScreen()));
          },
        ),
      ),
      body: Container(
        //   margin: EdgeInsets.only(top: size.height / 2 - 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/icons/image.png",
                height: 400,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0XFF7C66E9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 33,
                            color: Colors.black.withOpacity(.3))
                      ]),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
