import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OnlinepaymentScreen extends StatelessWidget {
  OnlinepaymentScreen(
      {super.key,
      this.count,
      required this.totalamount,
      this.model,
      this.size,
      required this.address,
      this.counts,
      this.models,
      this.prices,
      this.sizes});
  int? count;
  int totalamount;
  ProductModel? model;
  String? size;
  List<String> address;
  List<int>? counts;
  List<ProductModel>? models;
  List<String>? sizes;
  List<int>? prices;
  @override
  Widget build(BuildContext context) {
    bool isloading = false;

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is OnlinePaymentInitiatedState) {
            isloading = true;
          } else if (state is WalletPurchasedState) {
            Navigator.of(context).pushAndRemoveUntil(
                (MaterialPageRoute(
                    builder: (context) => OrderSuccessPage(
                          orderId: state.orderId,
                          orderDate: state.orderDate,
                          orderTime: state.orderTime,
                        ))),
                (route) => false);
          } else if (state is OnlinePaymentCancelState) {
            isloading = false;
            snackBar(context, 'Payment Cancelled');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text('Online Payment'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Lottie.asset("assets/images/online.json",
                      width: double.infinity, height: 300),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Lottie.asset(
                                'assets/images/securepayment.json')),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Your payment is 100% secure with our trusted payment gateway.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child:
                                Lottie.asset('assets/images/fastpayment.json')),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Fast and seamless payments to save your valuable time.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Lottie.asset('assets/images/reliable.json')),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Trusted by thousands of customers for secure and smooth transactions.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  NormalButton(
                    onTap: models == null
                        ? () {
                            context.read<PaymentBloc>().add(
                                PaymentThroughOnlineEvent(
                                    count!, model!.productId!, size!, address,
                                    amount: totalamount));
                          }
                        : () {
                            context.read<PaymentBloc>().add(
                                PaymentThroughOnlineForCartEvent(
                                    total: totalamount,
                                    models: models!,
                                    counts: counts!,
                                    sizes: sizes!,
                                    prices: prices!,
                                    address: address));
                          },
                    buttonTxt: 'Pay $rupee $totalamount',
                    color: Colors.green.shade800,
                    widgets:
                        isloading ? const CircularProgressIndicator() : null,
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
