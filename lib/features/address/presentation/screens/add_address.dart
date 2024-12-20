import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/common_widgets/textform_field.dart';
import 'package:finalproject/features/address/presentation/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key, this.addresss, this.index});

  final _formKey = GlobalKey<FormState>();
  final List<String>? addresss;
  final int? index;

  // Controllers for each TextFormField
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  // Function to clear all text controllers
  void clearTextFields() {
    fullNameController.clear();
    phoneController.clear();
    pincodeController.clear();
    stateController.clear();
    houseNameController.clear();
    roadNameController.clear();
    landmarkController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (addresss != null) {
      fullNameController.text = addresss![0];
      phoneController.text = addresss![1];
      pincodeController.text = addresss![2];
      stateController.text = addresss![3];
      houseNameController.text = addresss![4];
      roadNameController.text = addresss![5];
      landmarkController.text = addresss![6];
    }
    bool isloading = false;
    return BlocProvider(
      create: (context) => AddressBloc(),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressLoadingState) {
            isloading = true;
          }
          if (state is AddressAddedState) {
            isloading = false;
            snackBar(context, 'Address Added Successfully');
            clearTextFields(); // Clear fields when address is successfully added
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: index == null
                  ? const Text(
                      'Add Delivery Address',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'Edit Delivery Address',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey, // Assign the form key to the Form widget
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kheight30,
                      Textformfields(
                        controller: fullNameController,
                        icon: const Icon(Icons.person),
                        labeltext: 'Full Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: phoneController,
                        icon: const Icon(Icons.phone),
                        labeltext: 'Phone Number',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: pincodeController,
                        icon: const Icon(Icons.post_add),
                        labeltext: 'Pincode',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your pincode';
                          } else if (value.length != 6) {
                            return 'Pincode must be 6 digits';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: stateController,
                        icon: const Icon(Icons.place),
                        labeltext: 'State',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: houseNameController,
                        icon: const Icon(Icons.house),
                        labeltext: 'House Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your house name';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: roadNameController,
                        icon: const Icon(Icons.place_sharp),
                        labeltext: 'Road Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your road name';
                          }
                          return null;
                        },
                      ),
                      kheight30,
                      Textformfields(
                        controller: landmarkController,
                        icon: const Icon(Icons.label),
                        labeltext: 'District',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a District';
                          }
                          return null;
                        },
                      ),
                      kheight40,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: index == null
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      final address =
                                          '${fullNameController.text}&${phoneController.text}&${pincodeController.text}&${stateController.text}&${houseNameController.text}&${roadNameController.text}&${landmarkController.text}';
                                      print(address);
                                      context
                                          .read<AddressBloc>()
                                          .add(AddAddress(address: address));
                                    }
                                  }
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      final address =
                                          '${fullNameController.text}&${phoneController.text}&${pincodeController.text}&${stateController.text}&${houseNameController.text}&${roadNameController.text}&${landmarkController.text}';
                                      print(address);
                                      context.read<AddressBloc>().add(
                                          EditAdressEvent(
                                              address: address, index: index!));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              backgroundColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: isloading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Add Address',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
