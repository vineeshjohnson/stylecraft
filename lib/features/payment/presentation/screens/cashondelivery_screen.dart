import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CashondeliveryScreen extends StatelessWidget {
  const CashondeliveryScreen(
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

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isloading = true;
          } else if (state is WalletPurchasedState) {
            isloading = false;

            navigateTo(context, state);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text('Cash On Delivery'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  kheight20,
                  Text(
                    'Confirm Cash On Delivery Order',
                    style: TextStyle(fontSize: 30, fontFamily: font2),
                  ),
                  Container(
                    child: Lottie.asset(
                      'assets/images/cod.json', // Path to your Lottie file
                      width: double.infinity, // Set desired width
                      height: 300, // Set desired height
                    ),
                  ),
                  kheight30,
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Pay Via Upi or Cash when you \n receive your order',
                          style: TextStyle(fontFamily: font4, fontSize: 40),
                        )
                      ],
                    ),
                  ),
                  kheight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NormalButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonTxt: 'Cancel',
                        color: Colors.redAccent,
                      ),
                      NormalButton(
                        onTap: () {
                          context.read<PaymentBloc>().add(
                              CodPaymentProceedEvent(
                                  count: count,
                                  price: totalamount,
                                  productid: model.productId!,
                                  size: size,
                                  address: address));
                        },
                        buttonTxt: isloading ? 'Processing' : 'Confirm Order',
                        color: Colors.greenAccent.shade700,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> navigateTo(BuildContext context, WalletPurchasedState state) {
  return Navigator.of(context).pushAndRemoveUntil(
      (MaterialPageRoute(
          builder: (context) => OrderSuccessPage(
                orderId: state.orderId,
                orderDate: state.orderDate,
                orderTime: state.orderTime,
              ))),
      (route) => false);
}
