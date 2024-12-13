import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../products/presentation/widgets/appbar_widget.dart';

class CashOnDeliveryScreen extends StatelessWidget {
  CashOnDeliveryScreen({
    super.key,
    this.count,
    required this.totalAmount,
    this.model,
    this.size,
    required this.address,
    this.counts,
    this.models,
    this.prices,
    this.sizes,
  });

  final int? count;
  final int totalAmount;
  final ProductModel? model;
  final String? size;
  final List<String> address;
  final List<int>? counts;
  final List<ProductModel>? models;
  final List<String>? sizes;
  final List<int>? prices;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isLoading = true;
          } else if (state is WalletPurchasedState) {
            isLoading = false;
            navigateTo(context, state);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarWidget(
                title: 'Cash On Delivery',
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Confirm Cash On Delivery Order',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: font2,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Lottie.asset(
                    'assets/images/cod.json',
                    width: double.infinity,
                    height: 250,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Pay via UPI or Cash when you receive your order',
                        style: TextStyle(
                          fontFamily: font4,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                      isLoading
                          ? CircularProgressIndicator()
                          : NormalButton(
                              onTap: models == null
                                  ? () {
                                      context.read<PaymentBloc>().add(
                                            CodPaymentProceedEvent(
                                              count: count!,
                                              price: totalAmount,
                                              productid: model!.productId!,
                                              size: size!,
                                              address: address,
                                            ),
                                          );
                                    }
                                  : () {
                                      context.read<PaymentBloc>().add(
                                            PaymentThroughCodForCartEvent(
                                              models: models!,
                                              counts: counts!,
                                              sizes: sizes!,
                                              prices: prices!,
                                              address: address,
                                              total: totalAmount,
                                            ),
                                          );
                                    },
                              buttonTxt:
                                  isLoading ? 'Processing...' : 'Confirm Order',
                              color: Colors.green.shade700,
                            ),
                    ],
                  ),
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
    MaterialPageRoute(
      builder: (context) => OrderSuccessPage(
        orderId: state.orderId,
        orderDate: state.orderDate,
        orderTime: state.orderTime,
      ),
    ),
    (route) => false,
  );
}
