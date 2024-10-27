import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/product_details/presentation/screens/product_details.dart';
import 'package:finalproject/features/products/presentation/product_screen/bloc/product_bloc.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:finalproject/features/products/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, this.category, this.brand, this.price});
  final String? category;
  final String? brand;
  final String? price;

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends State<ProductView> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          title: 'Products',
        ),
      ),
      body: BlocProvider(
        create: (context) {
          if (widget.category != null) {
            return ProductBloc()
              ..add(InitialProductFetchEvent(category: widget.category!));
          } else if (widget.brand != null) {
            return ProductBloc()
              ..add(BrandProductFetchEvent(brand: widget.brand!));
          } else {
            return ProductBloc()
              ..add(PriceProductFetchEvent(price: widget.price!));
          }
        },

        // create: widget.category != null
        //     ? (context) => ProductBloc()
        //       ..add(InitialProductFetchEvent(category: widget.category!))
        //     : (context) => ProductBloc()
        //       ..add(BrandProductFetchEvent(brand: widget.brand!)),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Box
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is ProductClickedState) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    productModel: state.productmodel,
                                  )))
                          .then((_) {
                        context.read<ProductBloc>().add(
                            InitialProductFetchEvent(
                                category: state.productmodel.category));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductsInitialFetched) {
                      return FutureBuilder<List<ProductModel>>(
                        future: state.fetchProducts,
                        builder: (context, snapshot) {
                          var products = snapshot.data;

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (products!.isEmpty) {
                            return const Center(
                                child: Text('No products found'));
                          } else if (snapshot.hasData) {
                            var filteredProducts = products.where((product) {
                              return product.name
                                      .toLowerCase()
                                      .contains(searchQuery) ||
                                  product.description
                                      .toLowerCase()
                                      .contains(searchQuery);
                            }).toList();

                            return GridView.builder(
                              itemCount: filteredProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.6,
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return ProductWidget(
                                  product: filteredProducts[index],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text('No products found'));
                          }
                        },
                      );
                    } else {
                      return const Center(child: Text('No products found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
