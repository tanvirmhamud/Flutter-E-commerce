import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Sql%20Database/productsqlmodel.dart';
import 'package:flutter_shopping_1/Sql%20Database/sqldatabase.dart';
import 'package:flutter_shopping_1/Tab/save_tab.dart';

class ProductsDetailsButtombar extends StatefulWidget {
  final DocumentSnapshot documents;
  final bool disablecartbutton;
  final Color color;
  final Color textcolor;
  final int order;

  const ProductsDetailsButtombar(
      {Key? key,
      required this.documents,
      required this.disablecartbutton,
      required this.color,
      required this.textcolor,
      required this.order})
      : super(key: key);

  @override
  _ProductsDetailsButtombarState createState() =>
      _ProductsDetailsButtombarState();
}

class _ProductsDetailsButtombarState extends State<ProductsDetailsButtombar> {
  bool addtocartclick = false;
  late bool disablecartbutton2;
  Sqldbprovider? sqldbprovider;
  late int order2;
  List<ProductModel> datas = [];

  bool gotocartbutton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqldbprovider = Sqldbprovider();
    getdata();
  }

  sqlsetdata(int orderno) {
    ProductModel productModel = ProductModel(
      name: widget.documents['name'],
      details: widget.documents['details'],
      price: widget.documents['price'],
      image: widget.documents['image'][0],
      orderno: orderno,
      productno: widget.documents['productno'],
    );
    sqldbprovider!.insertdata(productModel);
    print(productModel);
  }

  getdata() async {
    datas = await sqldbprovider!.getdata();
  }

  Future<dynamic> delectdata(int id1) async {
    var id = await sqldbprovider!.delete(id1);
    print(id);
  }

  firebaseupdatedata(int orderno) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(widget.documents.id)
        .update({"orderno": orderno}).then((result) {
      print("new USer true");
    }).catchError((onError) {
      print("onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    disablecartbutton2 = widget.disablecartbutton;
    order2 = widget.order;
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0)),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {},
                  icon: Icon(
                    addtocartclick ? Icons.bookmark_added : Icons.bookmark,
                    size: 30.0,
                  ),
                ),
              ),
              gotocartbutton
                  ? Container(
                      margin: EdgeInsets.all(5.0),
                      width: 170.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: disablecartbutton2 ? widget.color : Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaveTab(
                                    hasbacksaveproduct: true, hasavater: false),
                              ));
                        },
                        child: Text(
                          "Go to Cart Page",
                          style: TextStyle(
                              color: disablecartbutton2
                                  ? widget.textcolor
                                  : Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(5.0),
                      width: 170.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: disablecartbutton2 ? widget.color : Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: disablecartbutton2
                            ? null
                            : () {
                                if (datas.any((file) =>
                                    file.productno ==
                                    widget.documents['productno'])) {
                                  setState(() {});
                                  
                                } else {
                                  setState(() {
                                    sqlsetdata(order2);
                                  });
                                }

                                setState(
                                  () {
                                    addtocartclick = !addtocartclick;
                                    gotocartbutton = true;
                                  },
                                );
                                firebaseupdatedata(order2);
                                print(datas.contains(widget.documents['name']));
                              },
                        child: Text(
                          "Add To cart",
                          style: TextStyle(
                              color: disablecartbutton2
                                  ? widget.textcolor
                                  : Colors.white),
                        ),
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
