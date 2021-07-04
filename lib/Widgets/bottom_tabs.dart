import 'package:flutter/material.dart';

class Bottomtabs extends StatefulWidget {
  final int homeselectedtab;
  final Function tabpressed;
  const Bottomtabs(
      {Key? key, required this.homeselectedtab, required this.tabpressed})
      : super(key: key);

  @override
  _BottomtabsState createState() => _BottomtabsState();
}

class _BottomtabsState extends State<Bottomtabs> {
  int selectedtab = 0;

  @override
  Widget build(BuildContext context) {
    selectedtab = widget.homeselectedtab;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomtabsbtn(
            selected: selectedtab == 0 ? true : false,
            icon: selectedtab == 0 ? Icons.home : Icons.home_outlined,
            onpressed: () {
              widget.tabpressed(0);
            },
          ),
          bottomtabsbtn(
            selected: selectedtab == 1 ? true : false,
            icon: selectedtab == 1 ? Icons.search : Icons.search_outlined,
            onpressed: () {
              widget.tabpressed(1);
            },
          ),
          bottomtabsbtn(
            selected: selectedtab == 2 ? true : false,
            icon: selectedtab == 2
                ? Icons.bookmark_outlined
                : Icons.bookmark_border,
            onpressed: () {
              widget.tabpressed(2);
            },
          ),
          bottomtabsbtn(
            selected: selectedtab == 3 ? true : false,
            icon: selectedtab == 3 ? Icons.logout : Icons.logout_outlined,
            onpressed: () {
              widget.tabpressed(3);
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class bottomtabsbtn extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onpressed;

  const bottomtabsbtn({
    Key? key,
    required this.icon,
    required this.selected,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: selected
                    ? Theme.of(context).accentColor
                    : Colors.transparent),
          ),
        ),
        child: Icon(
          icon,
          size: 26.0,
          color: selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
