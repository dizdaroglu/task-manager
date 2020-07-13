import 'package:flutter/material.dart';

class AllTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFEFEEF2),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0XFF7C66E9),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            TaskCard(
              color: Color(0XFFF58867),
              when: "haftalık",
            ),
            TaskCard(
              color: Color(0XFF7A87BE),
              when: "günlük",
            ),
            TaskCard(
              color: Color(0XFF48B8AA),
              when: "aylık",
            )
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Color color;
  final String when;

  const TaskCard({
    Key key,
    this.color,
    this.when,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Task...\n"),
                TextSpan(text: "Tarih", style: TextStyle(fontSize: 13))
              ])),
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    when,
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
