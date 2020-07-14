import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPage = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < _numPage; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.1,
                  0.4,
                  0.7,
                  0.9
                ],
                    colors: [
                  Color(0XFF7C66E9),
                  Color(0XFF7C76E9),
                  Color(0XFF7C86E9),
                  Color(0XFF7C96E9)
                ])),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                  Container(
                    height: 530,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        PageViewScreen(
                          path: "assets/images/onboarding0.png",
                          title: "Görev yönetim sistemi nedir?",
                          subTitle:
                              "Görevlerinizi oluşturup takip edebildiğiniz bir uygulama. Kullanımı kolay ve anlaşılır.",
                        ),
                        PageViewScreen(
                          circleWidget: true,
                          path: "assets/images/onboarding1.png",
                          title: "Renkler neyi ifade ediyor?",
                          subTitle:
                              "Görevlerinizi oluşturup takip edebildiğiniz bir uygulama. Kullanımı kolay ve anlaşılır.",
                        ),
                        PageViewScreen(
                          path: "assets/images/onboarding2.png",
                          title: "Hadi o zaman başlayalım!",
                          subTitle:
                              "Hemen görevini oluştur ve kullanmaya başla !",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPage - 1
            ? Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text("Get started",
                          style: TextStyle(
                              color: Color(0xFF5B16D0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              )
            : Text(""));
  }
}

class PageViewScreen extends StatelessWidget {
  final String path;
  final String title;
  final String subTitle;
  final bool circleWidget;

  const PageViewScreen({
    Key key,
    this.path,
    this.title,
    this.subTitle,
    this.circleWidget = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              path,
              width: 300,
              height: 300,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          circleWidget
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleColor(
                      text: "Günlük",
                      color: Color(0XFF7A87BE),
                    ),
                    CircleColor(
                      text: "Haftalık",
                      color: Color(0XFFF58867),
                    ),
                    CircleColor(
                      text: "Aylık",
                      color: Color(0XFF48B8AA),
                    ),
                  ],
                )
              : Text(
                  subTitle,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}

class CircleColor extends StatelessWidget {
  final String text;
  final Color color;

  const CircleColor({
    Key key,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
