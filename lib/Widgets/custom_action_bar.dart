import 'package:flutter/material.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasbackarrow;
  final bool hastitle;
  final bool hasavater;
  const CustomActionBar({
    Key? key,
    required this.title,
    required this.hasbackarrow,
    required this.hastitle,
    required this.hasavater,
  }) : super(key: key);

  @override
  _CustomActionBarState createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  @override
  Widget build(BuildContext context) {
    bool _hasbackarrow = widget.hasbackarrow;
    bool _hastitle = widget.hastitle;
    bool _hasavater = widget.hasavater;
    return Container(
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.white, Colors.white.withOpacity(0)],
        begin: Alignment(0, 0),
        end: Alignment(0, 1),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasbackarrow)
            Container(
              alignment: Alignment.center,
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8.0),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasavater)
            Container(
              child: CircleAvatar(
                radius: 15.0,
              ),
            ),
          if (_hastitle)
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Pangolin',
                fontSize: 20.0,
              ),
            ),
          Container(
            alignment: Alignment.center,
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "0",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pangolin',
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
