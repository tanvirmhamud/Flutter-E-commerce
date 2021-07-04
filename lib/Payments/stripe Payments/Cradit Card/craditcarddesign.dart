import 'dart:math';

import 'package:flutter/material.dart';

class Craditcard extends StatefulWidget {
  const Craditcard({Key? key}) : super(key: key);

  @override
  _CraditcardState createState() => _CraditcardState();
}

class Cardfont extends StatelessWidget {
  const Cardfont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("XXXX XXXX XXXX XXXX"),
          SizedBox(
            height: 20.0,
          ),
          Text("Tanvir Mhamud")
        ],
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text("Visa Card")],
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  final double value;
  const CardContainer({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((value < 0.5) ? pi * value : (pi * (1 + value))),
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(20.0),
          height: 200.0,
          width: double.infinity,
          child: (value < 0.5) ? Cardfont() : CardBack(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Color(0xFFFF6F00), Colors.amberAccent],
              )),
        ),
      ),
    );
  }
}

class _CraditcardState extends State<Craditcard> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardContainer(
              value: value,
            ),
            Slider(
              value: value,
              onChanged: (newvalue) {
                setState(() {
                  value = newvalue;
                });
              },
              min: 0,
              max: 1,
            )
          ],
        ),
      ),
    );
  }
}
