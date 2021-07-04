import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Pages/products_details.dart';
import 'package:flutter_shopping_1/Widgets/custom_action_bar.dart';
import 'package:flutter_shopping_1/Widgets/radiousbutton.dart';
import 'package:flutter_shopping_1/Widgets/slideproduct.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  _ProductTabState createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('products');

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: FutureBuilder<QuerySnapshot>(
              future: _reference.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Sliderproducts(),
                            SizedBox(
                              height: 5.0,
                            ),
                            RadiousButton(),
                            SizedBox(
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  "All Product",
                                  style: TextStyle(
                                      fontFamily: 'Pangolin',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        itemCount: snapshot.data!.docs.length,
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.3 : 1.4);
                        },
                        itemBuilder: (context, index) {
                          DocumentSnapshot documents =
                              snapshot.data!.docs[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsDetails(
                                      documents: snapshot.data!.docs[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                                left: 5.0,
                                right: 5.0,
                                bottom: 5.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image.network(
                                        documents['image'][0],
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              documents['name'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'Pangolin',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$${documents['price']}",
                                            style: TextStyle(
                                              fontFamily: 'Pangolin',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          CustomActionBar(
            hasbackarrow: false,
            hasavater: true,
            hastitle: true,
            title: "Tanvir Mhamud",
          ),
        ],
      ),
    );
  }
}
