import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SliverImage extends StatefulWidget {
  final DocumentSnapshot documents;
  const SliverImage({
    Key? key,
    required this.documents,
  }) : super(key: key);

  @override
  _SliverImageState createState() => _SliverImageState();
}

class _SliverImageState extends State<SliverImage> {
  int selectedpage = 0;
  @override
  Widget build(BuildContext context) {
    List imagedata = widget.documents['image'];
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  selectedpage = num;
                });
              },
              children: [
                for (var i = 0; i < imagedata.length; i++)
                  Container(
                    child: Image.network(imagedata[i]),
                  )
              ],
            ),
            Positioned(
              bottom: 30.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < imagedata.length; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic,
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      width: selectedpage == i ? 25.0 : 12.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                          color: selectedpage == i ? Colors.red : Colors.indigo,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
