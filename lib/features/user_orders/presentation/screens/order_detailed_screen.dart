import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/user_orders/presentation/bloc/userorders_bloc.dart';
import 'package:finalproject/features/user_orders/presentation/screens/cancellation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/presentation/widgets/appbar_widget.dart';

class OrderDetailedScreen extends StatelessWidget {
  const OrderDetailedScreen(
      {super.key, required this.ordermodel, required this.productmodel});
  final OrderModel ordermodel;
  final ProductModel productmodel;
  List<String> trackOrder(OrderModel model) {
    List<String> track = [];
    if (model.confirmed == true) {
      track.add('Order Confirmed');
    }
    if (model.packed == true) {
      track.add('Order Packed');
    }
    if (model.shipped == true) {
      track.add('Order Shipped');
    }
    if (model.outofdelivery == true) {
      track.add('Out for delivery');
    }
    if (model.completed == true) {
      track.add('Order Delivered Successfully');
    }
    if (model.cancelled == true) {
      track.add('Order Cancelled');
    }
    return track;
  }

  List<String> trackOrderDate(OrderModel model) {
    List<String> track = [];
    if (model.confirmed == true) {
      track.add(model.date);
    }
    if (model.packed == true) {
      track.add(model.packeddate!);
    }
    if (model.shipped == true) {
      track.add(model.shippeddate!);
    }
    if (model.outofdelivery == true) {
      track.add(model.outfordeliverydate!);
    }
    if (model.completed == true) {
      track.add(model.completeddate!);
    }
    if (model.cancelled == true) {
      track.add(model.cancelleddate!);
    }
    return track;
  }

  @override
  Widget build(BuildContext context) {
    var v = trackOrder(ordermodel);
    var d = trackOrderDate(ordermodel);
    bool iscancelled = ordermodel.cancelled!;
    bool iscompleted = ordermodel.completed!;

    String paymentMode = findPaymentMode(ordermodel);

    return BlocProvider(
      create: (context) => UserordersBloc(),
      child: BlocConsumer<UserordersBloc, UserordersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBarWidget(
                  title: 'Order Details',
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text(
                        'Order ID - ${ordermodel.orderid}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    kheight30,
                    SizedBox(
                      // height: 170,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productmodel.name,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: font4),
                                ),
                                kheight10,
                                Text('${ordermodel.size}, Pants'),
                                kheight10,
                                Text(productmodel.brand),
                                kheight10,
                                Text('Qty:${ordermodel.count}'),
                                kheight20,
                                Text(
                                  "$rupee${ordermodel.price}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                productmodel.imagepath[0],
                                height: 200,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    kheight30,
                    const Divider(),
                    SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (contex, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        v[index] == 'Order Cancelled'
                                            ? Icons.dangerous_rounded
                                            : Icons.check_circle_rounded,
                                        color: v[index] == 'Order Cancelled'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        v[index],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        d[index],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 4,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                            itemCount: v.length)),
                    kheight20,
                    Divider(
                      thickness: 7,
                      color: Colors.grey.shade300,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Shipping Details'),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ordermodel.address[0],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          kheight10,
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                                style: const TextStyle(
                                    wordSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                "${ordermodel.address[4]}, ${ordermodel.address[5]}, ${ordermodel.address[3]}, ${ordermodel.address[2]}, ${ordermodel.address[6]}"),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Price Details'),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Product MRP'),
                              Text(
                                  '$rupee${productmodel.price + (productmodel.price * productmodel.discountpercent!) ~/ 100}')
                            ],
                          ),
                          kheight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Selling Price'),
                              Text('$rupee${productmodel.price}')
                            ],
                          ),
                          kheight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Discount'),
                              Text(
                                  '${rupee}${((productmodel.price * productmodel.discountpercent!) ~/ 100)}')
                            ],
                          ),
                          kheight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Shipping Charge'),
                              Text('${rupee}40')
                            ],
                          ),
                          kheight30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Amount'),
                              Text('$rupee${ordermodel.price}')
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Payment Mode : $paymentMode',
                                style: addressstyle,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "$rupee${ordermodel.price}",
                                style: addressstyle,
                              )
                            ],
                          ),
                          kheight10,
                          (ordermodel.completed! || ordermodel.cancelled!)
                              ? kheight10
                              : Row(
                                  children: [
                                    Text(
                                      'Estimate Delivery Date',
                                      style: addressstyle,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      ordermodel.estimatedeliverydate!,
                                      style:
                                          const TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                    kheight20,
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: iscancelled || iscompleted
                            ? []
                            : [
                                NormalButton(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CancellationReasonsPage(
                                                  paymentmethod: paymentMode,
                                                  model: ordermodel,
                                                )));
                                  },
                                  buttonTxt: 'Cancel',
                                  color: Colors.orange.shade900,
                                ),
                                const Text('Feel free to cancel your  order')
                              ],
                      ),
                    ),
                    kheight40,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String findPaymentMode(OrderModel model) {
  if (model.cashondelivery == true) {
    return 'Cash On Delivery';
  } else if (model.walletpayment == true) {
    return 'Wallet';
  } else {
    return 'Online Payment';
  }
}
