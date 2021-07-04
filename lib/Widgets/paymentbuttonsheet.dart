import 'package:flutter/material.dart';
import 'package:flutter_shopping_1/Stripe%20Payments/cardpage.dart';
import 'package:flutter_shopping_1/Stripe%20Payments/payments_methods.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class paymentsheet extends StatefulWidget {
  final double amount;
  const paymentsheet({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  _paymentsheetState createState() => _paymentsheetState();
}

class _paymentsheetState extends State<paymentsheet> {
  Color payoalbordercolor = Colors.black;
  Color cardbordercolor = Colors.black;
  Color paypalbackground = Colors.transparent;
  Color cardbackground = Colors.transparent;
  EdgeInsetsGeometry paypalpadding = EdgeInsets.zero;
  EdgeInsetsGeometry cardpadding = EdgeInsets.zero;
  String? paymentname;
  bool elevatedbuttondisable = true;

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 5));
      return 'Hello, Future Progress Dialog!';
    });
  }

  payViaNewCard(BuildContext context, String amountnum) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text('Loading...')),
    );

    var response = await StripeService.payWithNewCard(
      amount: "563",
      currency: 'USD',
    );
  }

  @override
  Widget build(BuildContext context) {
    String num = widget.amount.toString();
    return AnimatedContainer(
      duration: Duration(seconds: 5),
      height: 300.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            "Payment Select",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pangolin',
            ),
          ),
          SizedBox(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      payoalbordercolor = Colors.indigo;
                      cardbordercolor = Colors.black;
                      cardbackground = Colors.transparent;
                      paypalbackground = Color(0xFFEEEEEE);
                      paypalpadding = EdgeInsets.all(5.0);
                      cardpadding = EdgeInsets.zero;
                      paymentname = "Paypal";
                      elevatedbuttondisable = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: paypalpadding,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: paypalbackground,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: payoalbordercolor,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset("images/payment/paypal.png"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Paypal",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pangolin',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      payoalbordercolor = Colors.black;
                      cardbordercolor = Colors.indigo;
                      cardbackground = Color(0xFFEEEEEE);
                      paypalbackground = Colors.transparent;
                      cardpadding = EdgeInsets.all(5.0);
                      paypalpadding = EdgeInsets.zero;
                      paymentname = "Card";
                      elevatedbuttondisable = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: cardpadding,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: cardbackground,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: cardbordercolor,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset("images/payment/card.png"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Card",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pangolin',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: elevatedbuttondisable
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cardpage(),
                              ));
                          print(num);
                        },
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Pangolin',
                    ),
                    duration: Duration(milliseconds: 300),
                    child: Text(
                        "${paymentname == null ? "" : paymentname} Continue"),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_shopping_1/Stripe%20Payments/payments_methods.dart';
// import 'package:future_progress_dialog/future_progress_dialog.dart';

// class CardPAge extends StatefulWidget {
//   double amount;
//   CardPAge({Key? key, required this.amount}) : super(key: key);

//   @override
//   CardPAgeState createState() => CardPAgeState();
// }

// class CardPAgeState extends State<CardPAge> {
//   onItemPress(BuildContext context, int index) async {
//     switch (index) {
//       case 0:
//         payViaNewCard(context);
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/existing-cards');
//         break;
//     }
//   }

//   Future getFuture() {
//     return Future(() async {
//       await Future.delayed(Duration(seconds: 5));
//       return 'Hello, Future Progress Dialog!';
//     });
//   }

//   payViaNewCard(BuildContext context) async {
//     var result = await showDialog(
//       context: context,
//       builder: (context) =>
//           FutureProgressDialog(getFuture(), message: Text('Loading...')),
//     );
//     var response =
//         await StripeService.payWithNewCard(amount: '15000', currency: 'USD');

//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text(response.message),
//       duration:
//           new Duration(milliseconds: response.success == true ? 1200 : 3000),
//     ));
//   }

//   @override
//   void initState() {
//     super.initState();
//     StripeService.init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: ListView.separated(
//             itemBuilder: (context, index) {
//               Icon? icon;
//               Text? text;

//               switch (index) {
//                 case 0:
//                   icon = Icon(Icons.add_circle, color: theme.primaryColor);
//                   text = Text('Pay via new card');
//                   break;
//                 case 1:
//                   icon = Icon(Icons.credit_card, color: theme.primaryColor);
//                   text = Text('Pay via existing card');
//                   break;
//               }

//               return InkWell(
//                 onTap: () {
//                   onItemPress(context, index);
//                 },
//                 child: ListTile(
//                   title: text,
//                   leading: icon,
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) => Divider(
//                   color: theme.primaryColor,
//                 ),
//             itemCount: 2),
//       ),
//     );
//     ;
//   }
// }
