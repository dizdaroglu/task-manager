import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/taskData.dart';
import 'package:task_manager/screens/home_screen.dart';

class AllTaskScreen extends StatefulWidget {
  @override
  _AllTaskScreenState createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TaskData>(context).fetchTask().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<TaskData>(context);
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0XFFEFEEF2),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF7C66E9)),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 20),
              child: tasksData.tasks.length == 0
                  ? Center(
                      child: Text(
                        "Add a task",
                        style:
                            TextStyle(fontSize: 18, color: Color(0XFF7C66E9)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasksData.tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasksData.tasks[index];

                        return TaskCard(
                          id: task.id,
                          text: task.title,
                          date: task.dateTime,
                          typeColor: task.typeColor,
                        );
                      },
                    )),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String id;
  final String text;
  final String date;

  final int typeColor;
  final String when;

  const TaskCard({
    Key key,
    this.when,
    this.id,
    this.text,
    this.date,
    this.typeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (direction) async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Uyarı Mesajı"),
                content: Text("Silmek istiyor musunuz?"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        await Provider.of<TaskData>(context, listen: false)
                            .removeTask(id);

                        Navigator.pop(context, true);
                      },
                      child: Text("Delete")),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text("Cancel"))
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(typeColor), borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "$text\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextSpan(
                      text: "Başlama Tarihi: ",
                      style: TextStyle(fontSize: 11, height: 1.4)),
                  TextSpan(
                      text: "$date",
                      style: TextStyle(fontSize: 11, height: 1.4))
                ])),
                Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      control(typeColor),
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String control(int deger) {
  switch (deger) {
    case 4286220222:
      return "Günlük";
    case 4294281319:
      return "Haflalık";
    case 4282955946:
      return "Aylık";

    default:
      return "bos";
  }
}
//4286220222 = gunluk
//4294281319=haftalık
//4282955946=aylık
