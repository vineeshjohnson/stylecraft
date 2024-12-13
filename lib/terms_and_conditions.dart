import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.deepPurpleAccent,
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
              Container(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Welcome to StyleCraft! These terms and conditions outline the rules and regulations for the use of our application. By accessing or using our app, you agree to comply with these terms. If you do not agree with these terms, please do not use the app.',
                      style: TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: '1. General Terms',
                content: '''
• All prices and availability of products are subject to change without prior notice.
• You are responsible for maintaining the confidentiality of your account credentials.
• We reserve the right to terminate accounts that violate our terms.''',
              ),
              _buildSection(
                title: '2. Payments and Refunds',
                content: '''
• All payments must be made through the approved payment methods in the app.
• Refunds will be processed in accordance with our refund policy.
• We are not responsible for any delays caused by third-party payment providers.''',
              ),
              _buildSection(
                title: '3. User Responsibilities',
                content: '''
• You agree not to misuse the app or engage in activities that harm its functionality.
• You must provide accurate and complete information while registering or making purchases.
• Any unlawful use of the app will lead to immediate account suspension.''',
              ),
              _buildSection(
                title: '4. Limitation of Liability',
                content: '''
• We are not responsible for any damages or losses resulting from the use of the app.
• We do not guarantee the uninterrupted availability of the app.
• Any technical issues should be reported promptly to our support team.''',
              ),
              _buildSection(
                title: '5. Governing Law',
                content: '''
• These terms are governed by and construed in accordance with the laws of your jurisdiction.
• Any disputes will be resolved in the courts of the applicable region.''',
              ),
              _buildSection(
                title: '6. Contact Us',
                content: '''
If you have any questions or concerns about these terms, please contact us at support@stylecraft.com.''',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
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
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
                fontSize: 16, height: 1.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
