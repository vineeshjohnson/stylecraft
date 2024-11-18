import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/address/presentation/bloc/address_bloc.dart';
import 'package:finalproject/features/address/presentation/screens/add_address.dart';
import 'package:finalproject/features/address/widgets/address_widget.dart';
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
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
                title: Text(
                  'My Address',
                  style: TextStyle(fontFamily: font3, color: Colors.white),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<AddressBloc>().add(NavigateToAddAddress());
                    },
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 30,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Add a new address',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (BuildContext, index) => AddressWidget(
                        address: state.address[index],
                        index: index,
                      ),
                      separatorBuilder: (BuildContext, index) => Divider(
                        color: Colors.grey.shade100,
                        thickness: 15,
                      ),
                      itemCount: state.address.length,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is NoAddressState) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
                title: Text(
                  'My Address',
                  style: TextStyle(fontFamily: font3, color: Colors.white),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<AddressBloc>().add(NavigateToAddAddress());
                      },
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Add a new address',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    kheight90,
                    const Text('Address Not Found'),
                  ],
                ),
              ),
            );
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
