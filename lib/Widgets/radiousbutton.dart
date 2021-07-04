import 'package:flutter/material.dart';

class RadiousButton extends StatefulWidget {
  const RadiousButton({Key? key}) : super(key: key);

  @override
  _RadiousButtonState createState() => _RadiousButtonState();
}

class _RadiousButtonState extends State<RadiousButton> {
  
   Widget radiousbutton(String name,String image) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 10.0,
            bottom: 5.0,
          ),
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 30.0,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(0.2),
              )
            ],
            borderRadius: BorderRadius.circular(50.0)

          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(image,fit: BoxFit.cover,),
              )),
        ),
        Text(name,style: TextStyle(fontFamily: 'Pangolin',fontWeight: FontWeight.bold),),
      ],
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              radiousbutton('Free Shipping','images/shipping.png'),
              radiousbutton('Food Delivery','images/food.png'),
              radiousbutton('Marketing','images/marketing.png'),
              radiousbutton('Categories','images/category.png'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              radiousbutton('Digital Service','images/digital.png'),
              radiousbutton('Low Price Product','images/products.png'),
              radiousbutton('Fashion','images/fashion.png'),
              radiousbutton('New Products','images/new.png'),
            ],
          )
        ],
      ),
    );
  }
}
