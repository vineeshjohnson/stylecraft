import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FAQs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                question: '1. How do I place an order?',
                answer:
                    'To place an order, browse the products, add items to your cart, and proceed to checkout. Follow the on-screen instructions to complete the payment.',
              ),
              _buildFAQItem(
                question: '2. What payment methods are accepted?',
                answer:
                    'We accept all major credit and debit cards, UPI, net banking, and various digital wallets for payment.',
              ),
              _buildFAQItem(
                question: '3. Can I return or exchange a product?',
                answer:
                    'Yes, we have a hassle-free return and exchange policy. Ensure that you initiate the return or exchange within the specified period.',
              ),
              _buildFAQItem(
                question: '4. How can I track my order?',
                answer:
                    'After placing an order, you can track its status through the "Orders" section in your account dashboard.',
              ),
              _buildFAQItem(
                question: '5. What should I do if I receive a damaged product?',
                answer:
                    'If you receive a damaged product, contact our support team immediately with the order details and photos of the damaged item. We will assist you promptly.',
              ),
              _buildFAQItem(
                question: '6. How do I contact customer support?',
                answer:
                    'You can contact our customer support team via email at support@stylecraft.com or call us at +1 234 567 890 during business hours.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
