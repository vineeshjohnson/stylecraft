import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPaymentScreen extends StatelessWidget {
  const WalletPaymentScreen(
      {super.key,
      required this.count,
      required this.totalamount,
      required this.model,
      required this.size,
      required this.address});
  final int count;
  final int totalamount;
  final ProductModel model;
  final String size;
  final List<String> address;
  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    int walletmoney = 0;
    return BlocProvider(
      create: (context) => PaymentBloc()..add(PaymentThroughWalletEvent()),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is WalletAmountFetchedState) {
            walletmoney = state.walletamount;
          } else if (state is LoadingState) {
            isloading = true;
          } else if (state is WalletPurchasedState) {
            isloading = false;
            Navigator.of(context).pushAndRemoveUntil(
                (MaterialPageRoute(
                    builder: (context) => OrderSuccessPage(
                        orderId: state.orderId,
                        orderDate: state.orderDate,
                        orderTime: state.orderTime,
                        walletAmount: state.walletAmount))),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text('Wallet Payment'),
            ),
            body: Column(
              children: [
                Container(
                  height: 90,
                  width: double.infinity,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 90,
                        width: 70,
                        color: Colors.white,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Text(
                        'Use your Style  Craft Wallet for easy Payment',
                        style: TextStyle(
                            fontFamily: font2,
                            fontSize: 18,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                kheight10,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Style Craft Wallet Balance',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$rupee $walletmoney',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'Your Wallet Having Sufficient Money For\n Purchase Through Wallet!!',
                  style: TextStyle(fontSize: 20, fontFamily: font4),
                ),
                kheight30,
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  height: 250,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product Price',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$rupee ${model.price}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product Qty',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$count',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Shipping Charge',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$rupee 40',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amout',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$rupee $totalamount',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                kheight30,
                NormalButton(
                  onTap: () {
                    context.read<PaymentBloc>().add(WalletPaymentProceedEvent(
                        count: count,
                        price: totalamount,
                        productid: model.productId!,
                        size: size,
                        address: address));
                  },
                  buttonTxt:
                      isloading ? 'Payment Processing' : 'Pay With Wallet',
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
