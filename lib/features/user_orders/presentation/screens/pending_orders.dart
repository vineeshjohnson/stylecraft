import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/user_orders/presentation/bloc/userorders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = [];
    List<OrderModel> orders = [];

    return BlocProvider(
      create: (context) =>
          UserordersBloc()..add(PendingUserOrdersFetchingEvent()),
      child: BlocConsumer<UserordersBloc, UserordersState>(
        listenWhen: (previous, current) {
          if (previous == current) {
            return false;
          } else {
            return true;
          }
        },
        listener: (context, state) {
          if (state is PendingOrdersState) {
            products = state.products;
            orders = state.orders;
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 110,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 90,
                              height: 90,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: 5,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                kheight30,
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 110,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                        products[index].imagepath[0]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          products[index].name,
                                          style: addressstyle,
                                        ),
                                        Text('Size:${orders[index].size}'),
                                        Text("$rupee ${orders[index].price}")
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: 35,
                                          width: 90,
                                          child: const Center(
                                            child: Text('In Transist'),
                                          ),
                                        ),
                                        TrackButton(
                                          onTap: () {},
                                          buttonTxt: 'Track',
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => kheight20,
                        itemCount: orders.length)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TrackButton extends StatelessWidget {
  const TrackButton(
      {super.key, required this.onTap, required this.buttonTxt, this.color});

  final VoidCallback onTap;
  final String buttonTxt;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 7),
        backgroundColor: color ?? Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        child: Text(
          buttonTxt,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
