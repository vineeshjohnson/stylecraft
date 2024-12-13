import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/payment/presentation/screens/cashondelivery_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/onlinepayment_screen.dart';
import 'package:finalproject/features/payment/presentation/screens/wallet_payment_screen.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    super.key,
    this.product,
    required this.address,
    this.productcount,
    this.productprice,
    required this.discount,
    required this.total,
    this.size,
    this.productcounts,
    this.productprices,
    this.products,
    this.sizes,
  });

  final ProductModel? product;
  final List<String> address;
  final int? productcount;
  final int? productprice;
  final int discount;
  final int total;
  final String? size;

  List<int>? productcounts;
  List<int>? productprices;
  List<ProductModel>? products;
  List<String>? sizes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(
            title: 'Payment',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Indicator
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StepIndicator(
                        icon: Icons.check_circle_outline, label: 'Address'),
                    _StepDivider(),
                    _StepIndicator(
                        icon: Icons.check_circle_outline,
                        label: 'Order Summary'),
                    _StepDivider(),
                    _StepIndicator(icon: Icons.payment, label: 'Payment'),
                  ],
                ),
              ),
              const Divider(thickness: 10),
              kheight20,
              // Product Details Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Product Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              kheight10,
              products == null
                  ? _SingleProductCard(
                      product: product!,
                      size: size!,
                      count: productcount!,
                      price: productprice!,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _MultiProductCard(
                        product: products![index],
                        size: sizes![index],
                        count: productcounts![index],
                        price: productprices![index],
                      ),
                      separatorBuilder: (context, index) => kheight10,
                      itemCount: products!.length,
                    ),
              kheight30,
              // Payment Options
              _PaymentOption(
                label: 'Online Payment',
                icon: Icons.payment,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => products == null
                        ? OnlinepaymentScreen(
                            count: productcount!,
                            totalamount: total,
                            model: product!,
                            size: size!,
                            address: address,
                          )
                        : OnlinepaymentScreen(
                            totalamount: total,
                            address: address,
                            prices: productprices,
                            models: products,
                            sizes: sizes,
                            counts: productcounts,
                          ),
                  ));
                },
              ),
              _PaymentOption(
                label: 'Wallet Payment',
                icon: Icons.wallet_giftcard,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => products == null
                        ? WalletPaymentScreen(
                            count: productcount!,
                            totalamount: total,
                            model: product!,
                            size: size!,
                            address: address,
                          )
                        : WalletPaymentScreen(
                            totalamount: total,
                            address: address,
                            prices: productprices,
                            sizes: sizes,
                            models: products,
                            counts: productcounts,
                          ),
                  ));
                },
              ),
              _PaymentOption(
                label: 'Cash On Delivery',
                icon: Icons.money,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => products == null
                        ? CashOnDeliveryScreen(
                            count: productcount!,
                            totalAmount: total,
                            model: product!,
                            size: size!,
                            address: address,
                          )
                        : CashOnDeliveryScreen(
                            totalAmount: total,
                            address: address,
                            prices: productprices,
                            sizes: sizes,
                            models: products,
                            counts: productcounts,
                          ),
                  ));
                },
              ),
              kheight40,
            ],
          ),
        ),
      ),
    );
  }
}

// Step Indicator Widget
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 25, color: Colors.blueAccent),
        Text(label),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Colors.blueAccent,
      width: 80,
    );
  }
}

// Single Product Card Widget
class _SingleProductCard extends StatelessWidget {
  const _SingleProductCard({
    Key? key,
    required this.product,
    required this.size,
    required this.count,
    required this.price,
  }) : super(key: key);

  final ProductModel product;
  final String size;
  final int count;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 130,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.imagepath[0]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Size: $size',
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                Text('Qty: $count', style: const TextStyle(fontSize: 14)),
                Text('Total: \u20B9$price',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Multi Product Card Widget
class _MultiProductCard extends StatelessWidget {
  const _MultiProductCard({
    Key? key,
    required this.product,
    required this.size,
    required this.count,
    required this.price,
  }) : super(key: key);

  final ProductModel product;
  final String size;
  final int count;
  final int price;

  @override
  Widget build(BuildContext context) {
    return _SingleProductCard(
      product: product,
      size: size,
      count: count,
      price: price,
    );
  }
}

// Payment Option Widget
class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              Icon(icon, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
