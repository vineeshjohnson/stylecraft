import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/screens/cashondelivery_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/onlinepayment_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/wallet_payment_screen.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen(
      {super.key,
      this.product,
      required this.address,
      this.productcount,
      this.productprice,
      required this.discount,
      required this.total,
      this.size,
      this.productcounts,
      this.productprices,
      this.products,
      this.sizes});
  final ProductModel? product;
  final List<String> address;
  final int? productcount;
  final int? productprice;
  final int discount;
  final int total;
  final String? size;

  List<int>? productcounts;
  List<int>? productprices;
  List<ProductModel>? products;
  List<String>? sizes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(
            title: 'Payment',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
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
              products == null
                  ? Container(
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
                                          image: NetworkImage(
                                              product!.imagepath[0]),
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
                                      product!.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Size : $size ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade600),
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
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
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
                                              image: NetworkImage(
                                                  products![index]
                                                      .imagepath[0]),
                                              fit: BoxFit.fill)),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          products![index].name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Size : ${sizes![index]} ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade600),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text('Qty ${productcounts![index]}'),
                                        Text(
                                          'Total Amount : \u20B9${productprices![index]}',
                                          style: addressstyle,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => kheight10,
                      itemCount: products!.length),
              kheight20,
              kheight30,
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => products == null
                          ? OnlinepaymentScreen(
                              count: productcount!,
                              totalamount: total,
                              model: product!,
                              size: size!,
                              address: address)
                          : OnlinepaymentScreen(
                              totalamount: total,
                              address: address,
                              prices: productprices,
                              models: products,
                              sizes: sizes,
                              counts: productcounts,
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
                      builder: (context) => products == null
                          ? WalletPaymentScreen(
                              count: productcount!,
                              totalamount: total,
                              model: product!,
                              size: size!,
                              address: address,
                            )
                          : WalletPaymentScreen(
                              totalamount: total,
                              address: address,
                              prices: productprices,
                              sizes: sizes,
                              models: products,
                              counts: productcounts,
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
                      builder: (contex) => products == null
                          ? CashondeliveryScreen(
                              count: productcount!,
                              totalamount: total,
                              model: product!,
                              size: size!,
                              address: address,
                            )
                          : CashondeliveryScreen(
                              totalamount: total,
                              address: address,
                              prices: productprices,
                              sizes: sizes,
                              models: products,
                              counts: productcounts,
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
              ),
              kheight40
            ],
          ),
        ),
      ),
    );
  }
}
