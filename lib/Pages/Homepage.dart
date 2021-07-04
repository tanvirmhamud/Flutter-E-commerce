import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Login-Page/login_page.dart';
import 'package:flutter_shopping_1/Tab/product_tab.dart';
import 'package:flutter_shopping_1/Tab/profile-tab.dart';
import 'package:flutter_shopping_1/Tab/save_tab.dart';
import 'package:flutter_shopping_1/Tab/search_tab.dart';
import 'package:flutter_shopping_1/Widgets/bottom_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int selectedtab = 0;
  var email;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _pageController = PageController();
    getloginemail();
    super.initState();
  }

  getloginemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        email = preferences.getString('email');
      },
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: PageView(
                controller: _pageController,
                onPageChanged: (num) {
                  setState(() {
                    selectedtab = num;
                  });
                },
                children: [
                  ProductTab(),
                  SearchTab(),
                  SaveTab(
                    hasbacksaveproduct: false,
                    hasavater: true,
                  ),
                  if (email == null) LoginPage(),
                  if (email != null) ProfileTab(),
                ],
              ),
            ),
          ),
          Bottomtabs(
            homeselectedtab: selectedtab,
            tabpressed: (num) {
              _pageController!.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
