import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Pages/products_details.dart';

class SuggestProducts extends StatefulWidget {
  const SuggestProducts({Key? key}) : super(key: key);

  @override
  _SuggestProductsState createState() => _SuggestProductsState();
}

class _SuggestProductsState extends State<SuggestProducts> {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder<QuerySnapshot>(
        future: reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documents = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsDetails(
                            documents: snapshot.data!.docs[index],
                          ),
                        ));
                  },
                  child: Container(
                    width: 300.0,
                    height: 200.0,
                    margin: EdgeInsets.only(
                      top: 5.0,
                      left: 5.0,
                      right: 5.0,
                      bottom: 5.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          child: Container(
                            padding: EdgeInsets.all(50.0),
                            child: Image.network(
                              documents['image'][0],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    ));
  }
}
