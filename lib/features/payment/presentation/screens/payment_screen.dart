import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/screens/cashondelivery_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/onlinepayment_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/wallet_payment_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key,
      required this.product,
      required this.address,
      required this.productcount,
      required this.productprice,
      required this.discount,
      required this.total,
      required this.size});
  final ProductModel product;
  final List<String> address;
  final int productcount;
  final int productprice;
  final int discount;
  final int total;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      Text('Address')
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.blueAccent,
                    width: 95,
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      Text('Order Summary')
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.blueAccent,
                    width: 95,
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.dangerous,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      Text('Payment')
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 10),
            kheight20,
            const Text(
              'Product Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(product.imagepath[0]),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Size : $size ',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text('Qty $productcount'),
                            Text(
                              'Total Amount : \u20B9$productprice',
                              style: addressstyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            kheight20,
            kheight30,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OnlinepaymentScreen(
                        count: productcount,
                        totalamount: total,
                        model: product,
                        size: size,
                        address: address)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Online Payment',
                      style: TextStyle(fontFamily: font4, fontSize: 30),
                    ),
                    const Icon(
                      Icons.payment,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            kheight30,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WalletPaymentScreen(
                          count: productcount,
                          totalamount: total,
                          model: product,
                          size: size,
                          address: address,
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Wallet Payment',
                      style: TextStyle(fontFamily: font4, fontSize: 30),
                    ),
                    const Icon(
                      Icons.wallet_giftcard,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            kheight30,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contex) => CashondeliveryScreen(
                          count: productcount,
                          totalamount: total,
                          model: product,
                          size: size,
                          address: address,
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Cash On Delivery',
                      style: TextStyle(fontFamily: font4, fontSize: 30),
                    ),
                    const Icon(
                      Icons.money,
                      size: 30,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
