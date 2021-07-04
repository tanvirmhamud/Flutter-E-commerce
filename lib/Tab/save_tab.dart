import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Sql%20Database/productsqlmodel.dart';
import 'package:flutter_shopping_1/Sql%20Database/sqldatabase.dart';
import 'package:flutter_shopping_1/Widgets/custom_action_bar.dart';
import 'package:flutter_shopping_1/Widgets/paymentbuttonsheet.dart';

class SaveTab extends StatefulWidget {
  final bool hasbacksaveproduct;
  final bool hasavater;
  const SaveTab(
      {Key? key, required this.hasbacksaveproduct, required this.hasavater})
      : super(key: key);

  @override
  _SaveTabState createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  Sqldbprovider? sqldbprovider;
  List<ProductModel> datas = [];
  bool isloading = true;
  int productorder = 0;

  bool showcount = false;
  double subtotal = 0.0;

  getdata() async {
    datas = await sqldbprovider!.getdata();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqldbprovider = Sqldbprovider();
    getdata();
  }

  Future<dynamic> delectdata(int id1) async {
    var id = await sqldbprovider!.delete(id1);
    print(id);
    setState(() {
      getdata();
    });
  }

  Future sqlupdatedata(ProductModel productModel) async {
    var update = await sqldbprovider!.update(productModel);
    print(update);
  }

  double get totoalammount {
    var total = 0.0;
    datas.forEach((ProductModel) {
      total = total + ProductModel.price;
    });

    return total;
  }

  _showbuttonsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return paymentsheet(
            amount: totoalammount,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 60.0,
                  ),
                  child: isloading
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: datas.length,
                                itemBuilder: (context, index) {
                                  var datafile = datas[index];

                                  return AnimatedContainer(
                                    duration: Duration(seconds: 2),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 10.0,
                                      bottom: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 90.0,
                                              width: 90.0,
                                              padding: EdgeInsets.all(10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  datafile.image,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      datafile.name,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Pangolin',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                            "\$${datafile.price}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Pangolin',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  int order =
                                                                      datafile
                                                                          .orderno++;
                                                                  print(order);
                                                                  sqlupdatedata(
                                                                      datafile);
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            child: Text(
                                                              "${datafile.orderno}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Pangolin',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  datafile
                                                                      .orderno--;
                                                                });
                                                                if (datafile
                                                                        .orderno <
                                                                    1) {
                                                                  setState(() {
                                                                    datafile
                                                                        .orderno = 0;
                                                                  });
                                                                }
                                                                sqlupdatedata(
                                                                    datafile);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                delectdata(datafile.id!);
                                              },
                                              icon: Icon(
                                                  Icons.delete_outline_rounded),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              height: 100.0,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Price:",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Pangolin',
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${totoalammount}",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Pangolin',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            _showbuttonsheet(context);
                                          },
                                          child: Text("Continue")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                CustomActionBar(
                  hasbackarrow: widget.hasbacksaveproduct,
                  hasavater: widget.hasavater,
                  hastitle: true,
                  title: "Save Product",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
