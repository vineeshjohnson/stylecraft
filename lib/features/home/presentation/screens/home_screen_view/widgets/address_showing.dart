import 'package:finalproject/features/address/presentation/screens/address.dart';
import 'package:finalproject/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class AddressShowingwidget extends StatelessWidget {
  const AddressShowingwidget({super.key, required this.state});
  final CategoryInitialFetchingState state;
  @override
  Widget build(BuildContext context) {
    final List<String> address =
        state.address.isNotEmpty ? state.address[0].split("&") : [];
    print(address);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddressScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 70,
        color: Colors.blueGrey.shade100,
        child: address.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 40,
                  ),
                  Text(
                    'Deliver to ${address[0]} -  ${address[5]} \n ${address[2]}',
                    style: const TextStyle(
                        fontFamily: 'AfacadFlux-SemiBold', fontSize: 17),
                  ),
                ],
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 40,
                    ),
                    Text(
                      'Add your Address Here for catch you fast',
                      style: TextStyle(
                          fontFamily: 'AfacadFlux-SemiBold', fontSize: 17),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
