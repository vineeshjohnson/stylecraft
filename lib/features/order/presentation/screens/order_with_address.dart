import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/address/presentation/screens/add_address.dart';
import 'package:finalproject/features/order/presentation/bloc/order_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/payment_screen.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWithAddress extends StatelessWidget {
  const OrderWithAddress({
    super.key,
    this.product,
    this.size,
  });
  final ProductModel? product;
  final String? size;

  @override
  Widget build(BuildContext context) {
    int selectedaddress = 0;
    int productcount = 1;
    int productprice = product!.price * productcount;
    int discount = productcount * 200;
    int shipping = 40;
    int totalamount = (productprice) + 40;

    List<List<String>> addresses = [];
    return BlocProvider(
      create: (context) => OrderBloc()..add(AddressaFetchingEvent()),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderDetailsTriggeredState) {
            productprice = state.price;
            discount = state.discountamount;
            totalamount = state.totalamount;
            productcount = state.count;
          } else if (state is AddressFetchedState) {
            for (int i = 0; i < state.address.length; i++) {
              addresses.add(state.address[i].split('&'));
            }
            print(addresses);
          } else if (state is NavigatedToAddAddressState) {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddAddressScreen(),
            ))
                .then((_) {
              context.read<OrderBloc>().add(AddressaFetchingEvent());
            });
          } else if (state is AddressChangedState) {
            selectedaddress = state.selectedindex;
            print(selectedaddress);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBarWidget(
                  title: 'Order Summary',
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 5),
                      child: bluetracking(addresses),
                    ),
                    Divider(
                      thickness: addresses.isNotEmpty ? 10 : 0,
                    ),
                    addressfunction(addresses, selectedaddress),
                    Divider(
                      thickness: addresses.isNotEmpty ? 10 : 0,
                    ),
                    productdetailsfunction(productprice, discount, context,
                        productcount, shipping),
                    kheight10,
                    continuenextpagewidget(),
                    pricedetailsfunction(productcount, productprice, discount,
                        shipping, totalamount),
                    infoboardfunction()
                  ],
                ),
              ),
              bottomNavigationBar: bottomappbarfunction(totalamount, addresses, context, selectedaddress, productcount, productprice, discount),
            ),
          );
        },
      ),
    );
  }

  BottomAppBar bottomappbarfunction(int totalamount, List<List<String>> addresses, BuildContext context, int selectedaddress, int productcount, int productprice, int discount) {
    return BottomAppBar(
                color: Colors.grey.shade300,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$rupee $totalamount',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      NormalButton(
                        onTap: addresses.isEmpty
                            ? () {
                                snackBar(context, 'Choose Any Address');
                              }
                            : () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                          product: product!,
                                          address: addresses[selectedaddress],
                                          productcount: productcount,
                                          productprice: productprice,
                                          discount: discount,
                                          total: totalamount,
                                          size: size!,
                                        )));
                              },
                        buttonTxt: 'Continue',
                        color: addresses.isNotEmpty
                            ? Colors.orangeAccent
                            : Colors.grey,
                      )
                    ],
                  ),
                ));
  }

  ListView addressfunction(List<List<String>> addresses, int selectedaddress) {
    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      itemBuilder: addresses.isNotEmpty
                          ? (BuildContext, index) => AddressWidget(
                                address: addresses[index],
                                index: index,
                                selectedindex: selectedaddress,
                              )
                          : (BuildContext, index) => const AddAddressWidget(),
                      separatorBuilder: (BuildContext, Index) => kheight10,
                      itemCount: addresses.isNotEmpty ? addresses.length : 1);
  }

  Container infoboardfunction() {
    return Container(
      color: Colors.grey.shade200,
      width: double.infinity,
      height: 80,
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.assured_workload),
            Text('Safe and Secure payment & 100 % Authentic Products')
          ],
        ),
      ),
    );
  }

  SizedBox pricedetailsfunction(int productcount, int productprice,
      int discount, int shipping, int totalamount) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price Details',
                style: addressstyle,
              ),
              kheight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price ($productcount item)'),
                  Text('$rupee $productprice')
                ],
              ),
              kheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Discount'), Text('$rupee $discount')],
              ),
              kheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Shipping Charge'),
                  Text('$rupee $shipping')
                ],
              ),
              kheight20,
              const Divider(
                thickness: 2,
              ),
              kheight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: addressstyle,
                  ),
                  Text(
                    '$rupee $totalamount',
                    style: addressstyle,
                  )
                ],
              ),
              kheight20,
              const Divider(
                thickness: 2,
              ),
              kheight20,
              Text(
                'You will save $rupee $discount in this order',
                style: addressstyle,
              ),
              kheight10,
            ],
          ),
        ));
  }

  Container continuenextpagewidget() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.blue.shade50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.credit_card,
              size: 30,
            ),
            Text(
              'Continue to the Next page for Payments',
              style: addressstyle,
            )
          ],
        ),
      ),
    );
  }

  Container productdetailsfunction(int productprice, int discount,
      BuildContext context, int productcount, int shipping) {
    return Container(
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
                          image: NetworkImage(product!.imagepath[0]),
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
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Size : $size',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    Text(
                      'Price: \u20B9${productprice + discount}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '\u20B9$productprice',
                      style: addressstyle,
                    ),
                    SizedBox(
                      height: 35,
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                context.read<OrderBloc>().add(
                                    TriggerOrderSummaryEvent(
                                        model: product!,
                                        productcount: productcount + 1));
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.green,
                                size: 25,
                              )),
                          Text(
                            productcount.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: productcount < 2
                                  ? () {
                                      snackBar(context,
                                          'Minimum 1 product should select');
                                    }
                                  : () {
                                      context.read<OrderBloc>().add(
                                          TriggerOrderSummaryEvent(
                                              model: product!,
                                              productcount: productcount - 1));
                                    },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                                size: 25,
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            kheight20,
            const Text('Delivery by Nov 20, Wed.'),
            Text('Shipping Charge  $rupee$shipping')
          ],
        ),
      ),
    );
  }

  Row bluetracking(List<List<String>> addresses) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(
              addresses.isNotEmpty
                  ? Icons.check_circle_outline
                  : Icons.dangerous,
              size: 30,
              color: Colors.blueAccent,
            ),
            const Text('Address')
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
    );
  }
}

class AddressWidget extends StatelessWidget {
  AddressWidget(
      {super.key,
      required this.address,
      required this.index,
      required this.selectedindex});
  final List<String> address;
  final int index;
  int selectedindex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {},
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Deliver To:',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                        value: index,
                        groupValue: selectedindex,
                        onChanged: (int? value) {
                          context.read<OrderBloc>().add(
                              AddressChangedEvent(selectedaddress: value!));
                        })
                  ],
                ),
                Text(address[0], style: addressstyle),
                kheight30,
                Text(
                  address.join(', '),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
                kheight20,
                Text(
                  address[1],
                  style: addressstyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
            child: NormalButton(
          onTap: () {
            context.read<OrderBloc>().add(NavigateToAddAddressEvent());
          },
          buttonTxt: 'Add Address',
          color: Colors.blue,
        )));
  }
}
