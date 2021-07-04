import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Pages/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // ignore: deprecated_member_use
        child: FlatButton(
          color: Colors.indigo,
          onPressed: () {
            logout();
          },
          child: Text("Log Out"),
        ),
      ),
    );
  }
}
