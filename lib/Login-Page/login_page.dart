import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Pages/Homepage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  bool passwordhide = true;
  bool islogin = true;

  String? email;
  String? password;

  void login() {
    final form = _formkey.currentState;
    if (form!.validate()) {
      form.save();
      signin();
      print("email: $email, password: $password");
      print("Form Valid");
    } else {
      print("Form Invalid");
    }
  }

  Future<void> signin() async {
    setState(() {
      islogin = false;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      if (userCredential.additionalUserInfo != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', email!);
        setState(() {
          islogin = true;
        });
        loginsuccessmessage();
        redurectuser();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          islogin = true;
        });
        loginerrormessage("User not found");

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          islogin = true;
        });
        loginerrormessage("Wrong password");

        print('Wrong password provided for that user.');
      } else {
        setState(() {
          islogin = true;
        });
      }
    }
  }

  void redurectuser() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  void loginsuccessmessage() {
    final snakbar = SnackBar(content: Text("Login Successfull"));
    // ignore: deprecated_member_use
    _scaffold.currentState!.showSnackBar(snakbar);
    _formkey.currentState!.reset();
  }

  void loginerrormessage(String errormessage) {
    final snakbar = SnackBar(content: Text(errormessage));
    // ignore: deprecated_member_use
    _scaffold.currentState!.showSnackBar(snakbar);
    _formkey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: SvgPicture.asset(
                    "images/login_img.svg",
                    height: 250.0,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Form(
                  key: _formkey,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextFormField(
                            autocorrect: true,
                            onSaved: (value) {
                              email = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Email";
                              } else if (!value.contains("@")) {
                                return "Invaild Email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: 'Pangolin'),
                                suffixIcon: Icon(Icons.email_rounded)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) => value!.length < 6
                                ? "Password is too sort"
                                : null,
                            obscureText: passwordhide,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: 'Pangolin'),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      passwordhide = !passwordhide;
                                    });
                                  },
                                  child: Icon(passwordhide
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        islogin == true
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  onPressed: () {
                                    login();
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Pangolin'),
                                  ),
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontFamily: 'Pangolin'),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pangolin',
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
    );
  }
}
