import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _formkey = GlobalKey<FormState>();
  String? searchvalue;

  searchvalidation() {
    final searchform = _formkey.currentState;
    if (searchform!.validate()) {
      searchform.save();
    }
  }

  searchmessage() {
    if (searchvalue == null) {
      return Container(
        padding: EdgeInsets.only(top: 200.0),
        child: Center(
          child: Text("Search Box Empty"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 50.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 20.0,
                        ),
                        child: Form(
                          key: _formkey,
                          child: TextFormField(
                            onSaved: (value) {
                              searchvalue = value;
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
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: 'Pangolin'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        focusColor: Colors.indigo,
                        color: Colors.indigo,
                        height: 55.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          searchvalidation();
                        },
                        child: Text(
                          "Search",
                          style: TextStyle(fontFamily: 'Pangolin'),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Search Iteam",
                      style: TextStyle(fontFamily: 'Pangolin'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
