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

class OrderwithAddressForCart extends StatelessWidget {
  const OrderwithAddressForCart({super.key, this.products});

  final List<ProductModel>? products;
  @override
  Widget build(BuildContext context) {
    int selectedaddress = 0;
    List<String> sizes = cartProductSize(products!);
    List<int> cartproductcount = cartProductCount(products!);
    List<int> cartproductprice = cartProductAmount(cartproductcount, products!);
    List<int> withoutdiscount =
        cartEachPrice(cartproductcount, cartproductprice);
    int totalcartcount = cartproductcount.reduce((a, b) => a + b);

    int cartproductdiscound = 200 * totalcartcount;
    int totalcartprice = cartproductprice.reduce((a, b) => a + b);

    List<List<String>> addresses = [];
    return BlocProvider(
      create: (context) => OrderBloc()..add(AddressaFetchingEvent()),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is CartCheckoutTriggeredState) {
            cartproductcount = state.newcounts;
            cartproductprice = cartProductAmount(cartproductcount, products!);
            withoutdiscount = cartEachPrice(cartproductcount, cartproductprice);
            totalcartcount = cartproductcount.reduce((a, b) => a + b);

            cartproductdiscound = 200 * totalcartcount;
            totalcartprice = cartproductprice.reduce((a, b) => a + b);
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
                  title: 'Check Out',
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 5),
                      child: Row(
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
                      ),
                    ),
                    Divider(
                      thickness: addresses.isNotEmpty ? 10 : 0,
                    ),
                    ListView.separated(
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
                        itemCount: addresses.isNotEmpty ? addresses.length : 1),
                    Divider(
                      thickness: addresses.isNotEmpty ? 10 : 0,
                    ),

                    //body section

                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        itemBuilder: (context, index) => Container(
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
                                              'Size : ${products![index].selectedsize}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade600),
                                            ),
                                            Text(
                                              'Price: \u20B9${withoutdiscount[index]}',
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              '\u20B9${cartproductprice[index]}',
                                              style: addressstyle,
                                            ),
                                            SizedBox(
                                              height: 35,
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<OrderBloc>()
                                                            .add(CartCheckoutProductIncrimentEvent(
                                                                index: index,
                                                                counts:
                                                                    cartproductcount,
                                                                prices:
                                                                    cartproductprice,
                                                                product:
                                                                    products!));
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: Colors.green,
                                                        size: 25,
                                                      )),
                                                  Text(
                                                    cartproductcount[index]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed:
                                                          cartproductcount[
                                                                      index] <
                                                                  2
                                                              ? () {
                                                                  snackBar(
                                                                      context,
                                                                      'Minimum 1 product should select');
                                                                }
                                                              : () {
                                                                  context.read<OrderBloc>().add(CartCheckoutProductDecrimentEvent(
                                                                      index:
                                                                          index,
                                                                      counts:
                                                                          cartproductcount,
                                                                      prices:
                                                                          cartproductprice,
                                                                      product:
                                                                          products!));
                                                                },
                                                      icon: const Icon(
                                                        Icons
                                                            .remove_circle_outline,
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
                                    Text('Shipping Charge  $rupee 40')
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => kheight10,
                        itemCount: products!.length),
                    kheight10,
                    Container(
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
                    ),
                    SizedBox(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Price ($totalcartcount item)'),
                                  Text('$rupee $totalcartprice')
                                ],
                              ),
                              kheight10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Discount'),
                                  Text('$rupee $cartproductdiscound')
                                ],
                              ),
                              kheight10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Shipping Charge'),
                                  Text('$rupee 40')
                                ],
                              ),
                              kheight20,
                              const Divider(
                                thickness: 2,
                              ),
                              kheight20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: addressstyle,
                                  ),
                                  Text(
                                    '$rupee ${totalcartprice + 40}',
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
                                'You will save $rupee $cartproductdiscound in this order',
                                style: addressstyle,
                              ),
                              kheight10,
                            ],
                          ),
                        )),
                    Container(
                      color: Colors.grey.shade200,
                      width: double.infinity,
                      height: 80,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.assured_workload),
                            Text(
                                'Safe and Secure payment & 100 % Authentic Products')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                  color: Colors.grey.shade300,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$rupee $totalcartprice',
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
                                            address: addresses[selectedaddress],
                                            discount: cartproductdiscound,
                                            total: totalcartprice,
                                            sizes: sizes,
                                            productcounts: cartproductcount,
                                            productprices: cartproductprice,
                                            products: products,
                                          )));
                                },
                          buttonTxt: 'Continue',
                          color: addresses.isNotEmpty
                              ? Colors.orangeAccent
                              : Colors.grey,
                        )
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
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

List<int> cartProductCount(List<ProductModel> models) {
  List<int> count = [];
  for (int i = 0; i < models.length; i++) {
    count.add(models[i].count!);
  }
  return count;
}

List<int> cartProductAmount(List<int> count, List<ProductModel> models) {
  List<int> amount = [];
  for (int i = 0; i < count.length; i++) {
    amount.add(count[i] * models[i].price);
  }
  return amount;
}

List<String> cartProductSize(List<ProductModel> models) {
  List<String> sizes = [];
  for (int i = 0; i < models.length; i++) {
    sizes.add(models[i].selectedsize!);
  }
  return sizes;
}

List<int> cartEachPrice(List<int> productcount, List<int> productprice) {
  List<int> discounts = [];
  for (int i = 0; i < productcount.length; i++) {
    int discount = (productcount[i] * 200) + productprice[i];
    discounts.add(discount);
  }
  return discounts;
}
