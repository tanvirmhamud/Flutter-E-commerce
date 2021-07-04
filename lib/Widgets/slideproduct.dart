import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class Sliderproducts extends StatefulWidget {
  const Sliderproducts({Key? key}) : super(key: key);

  @override
  _SliderproductsState createState() => _SliderproductsState();
}

class _SliderproductsState extends State<Sliderproducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 75.0),
      alignment: Alignment.center,
      height: 260.0,
      width: double.infinity,
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('slidepic').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Container(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return CarouselSlider.builder(
              slideIndicator: CircularSlideIndicator(
                indicatorRadius: 4.0,
                alignment: Alignment.bottomCenter,
              ),
              enableAutoSlider: true,
              unlimitedMode: true,
              itemCount: snapshot.data!.docs.length,
              slideBuilder: (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30.0,
                          spreadRadius: 1.0),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        width: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            "${snapshot.data!.docs[index]['image'][0]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            snapshot.data!.docs[index]['name'],
                            style: TextStyle(
                              fontFamily: 'Pangolin',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            height: 40.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {},
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                    fontFamily: 'Pangolin',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
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
    );
  }
}
