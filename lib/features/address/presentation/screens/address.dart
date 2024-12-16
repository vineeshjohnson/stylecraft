import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/address/presentation/bloc/address_bloc.dart';
import 'package:finalproject/features/address/presentation/functions.dart';
import 'package:finalproject/features/address/presentation/screens/add_address.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc()..add(AddressFetchingEvent()),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is NavigateToAddAddressState) {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddAddressScreen(),
            ))
                .then((_) {
              context.read<AddressBloc>().add(AddressFetchingEvent());
            });
          } else if (state is NavigateToEditAddressState) {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddAddressScreen(
                index: state.index,
                addresss: state.address,
              ),
            ))
                .then((_) {
              context.read<AddressBloc>().add(AddressFetchingEvent());
            });
          } else if (state is AddressDeletedState) {
            snackBar(context, 'address deletd');
          }
        },
        builder: (context, state) {
          if (state is AddressFetchedState) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade100,
                appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: AppBarWidget(
                    title: 'My Address',
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addnewaddressfunction(context),
                    kheight40,
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        '${state.address.length} SAVED ADDRESSES',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    addressshowingfunction(state),
                  ],
                ),
              ),
            );
          } else if (state is NoAddressState) {
            return noaddressfunction(context);
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
