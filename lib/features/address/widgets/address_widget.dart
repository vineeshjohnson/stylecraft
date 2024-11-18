import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/address/presentation/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.address, required this.index});
  final String address;
  final int index;
  @override
  Widget build(BuildContext context) {
    var list = address.split("&");
    var addresses = '${list[4]}, ${list[5]}, ${list[2]}';
    print(list);
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3),
        ),
      ]),
      height: 250,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  list[0],
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.read<AddressBloc>().add(
                          NavigateToEditAddress(address: list, index: index));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => AddAddressScreen(
                      //           addresss: list,
                      //           index: index,
                      //         )));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      context
                          .read<AddressBloc>()
                          .add(DeleteAddressEvent(index: index));
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            kheight30,
            Text(
              addresses,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            kheight20,
            Text(
              list[1],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
