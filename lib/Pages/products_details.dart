import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Sql%20Database/productsqlmodel.dart';
import 'package:flutter_shopping_1/Sql%20Database/sqldatabase.dart';
import 'package:flutter_shopping_1/Widgets/custom_action_bar.dart';
import 'package:flutter_shopping_1/Widgets/product_details_buttom_bar.dart';
import 'package:flutter_shopping_1/Widgets/sliverslideimaeg.dart';
import 'package:flutter_shopping_1/Widgets/suggestproducts.dart';

class ProductsDetails extends StatefulWidget {
  final DocumentSnapshot documents;

  const ProductsDetails({Key? key, required this.documents}) : super(key: key);

  @override
  _ProductsDetailsState createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  bool disablebutton = true;
  Color buttoncolor = Colors.grey[400]!;
  Color textcolor = Colors.black;
  List<ProductModel> datas = [];
  Sqldbprovider? sqldbprovider;
  // ignore: avoid_init_to_null

  int order = 0;

  getdata() async {
    datas = await sqldbprovider!.getdata();
  }

  void increment() {
    setState(() {
      order++;
      disablebutton = false;
      buttoncolor = Colors.black;
      textcolor = Colors.white;
    });
  }

  void dicreement() {
    setState(() {
      order--;
    });
    if (order < 1) {
      setState(() {
        order = 0;
        disablebutton = true;
        buttoncolor = Colors.grey[400]!;
        textcolor = Colors.black;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqldbprovider = Sqldbprovider();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: ProductsDetailsButtombar(
        documents: widget.documents,
        disablecartbutton: disablebutton,
        color: buttoncolor,
        textcolor: textcolor,
        order: order,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 350.0,
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: SliverImage(
                    documents: widget.documents,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      left: 10.0,
                                    ),
                                    child: Text(
                                      widget.documents['name'],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pangolin',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 10.0,
                                ),
                                child: Text(
                                  "Price:",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Pangolin',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  "\$${widget.documents['price']}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pangolin',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  "Order",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pangolin',
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          increment();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "$order",
                                        style: TextStyle(
                                            fontFamily: 'Pangolin',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: GestureDetector(
                                        onTap: dicreement,
                                        child: Icon(
                                          Icons.remove,
                                          size: 20.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 20.0,
                              left: 10.0,
                            ),
                            child: Text(
                              "Details:",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pangolin',
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Divider(
                                height: 10.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              left: 10.0,
                            ),
                            child: Text(
                              widget.documents['details'],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Pangolin',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 20.0,
                              left: 10.0,
                            ),
                            child: Text(
                              "Suggest For You:",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pangolin',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                              height: 300.0,
                              width: double.infinity,
                              color: Colors.green,
                              child: SuggestProducts()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          CustomActionBar(
            hasbackarrow: true,
            hasavater: false,
            hastitle: false,
            title: "Tanvir Mhamud",
          ),
        ],
      ),
    );
  }
}
