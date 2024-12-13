import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/payment/presentation/screens/order_cancel_screen.dart';
import 'package:finalproject/features/user_orders/presentation/bloc/userorders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CancellationReasonsPage extends StatelessWidget {
  CancellationReasonsPage(
      {super.key, required this.model, required this.paymentmethod});
  final OrderModel model;
  final String paymentmethod;
  String? selectedReason;

  final TextEditingController _commentController = TextEditingController();

  final List<String> reasons = [
    "Size doesn't fit",
    "Wrong item delivered",
    "Product quality not as expected",
    "Changed my mind",
    "Found a better deal elsewhere",
    "Delivery took too long",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserordersBloc(),
      child: BlocConsumer<UserordersBloc, UserordersState>(
        listener: (context, state) {
          if (state is CancelReasonSelectedState) {
            selectedReason = state.selectedreason;
          } else if (state is CancelledState) {
            snackBar(context, 'Order Cancelled SuccessFully');
            Navigator.of(context).pushAndRemoveUntil(
                (MaterialPageRoute(
                    builder: (context) => OrderCancelScreen(
                        orderdetails: model,
                        orderId: state.model.orderid!,
                        orderDate: state.model.date,
                        orderTime: state.model.time))),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cancel Product"),
              backgroundColor: Colors.redAccent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select a reason for cancellation:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  kheight20,
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reasons.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(reasons[index]),
                          leading: Radio<String>(
                            value: reasons[index],
                            groupValue: selectedReason,
                            onChanged: (value) {
                              context.read<UserordersBloc>().add(
                                  OrderCancelReasonSelectioEvent(
                                      reasonindex: value!));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  kheight30,
                  const Text(
                    "Add a comment (optional):",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write your comments here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalButton(
                        onTap: () {
                          if (selectedReason == null) {
                            snackBar(context, 'select any reason for cancel');
                          } else {
                            context.read<UserordersBloc>().add(
                                OrderCancellationEvent(
                                    model: model,
                                    reason: selectedReason! +
                                        _commentController.text,
                                    paymentmode: paymentmethod));
                          }
                        },
                        buttonTxt: 'Cancel Anyway',
                        color: Colors.red.shade900,
                      ),
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
