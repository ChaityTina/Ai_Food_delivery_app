import 'package:flutter/material.dart';

class notifications extends StatelessWidget {
  const notifications({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget notificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      horizontalTitleGap: 12,
    );
  }

  Widget circularBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: circularBackButton(context),
        title: const Text('Notification', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          sectionTitle("Today"),
          notificationItem(
            icon: Icons.local_offer,
            iconColor: Colors.red,
            title: "30% Special Discount!",
            subtitle: "Special promotion only valid today",
          ),
          notificationItem(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: "Your Order Has Been Taken by the Driver",
            subtitle: "Recently!",
          ),
          const Divider(thickness: 1, indent: 16, endIndent: 16),
          notificationItem(
            icon: Icons.cancel,
            iconColor: Colors.red,
            title: "Your Order Has Been Canceled",
            subtitle: "19 Jun 2023",
          ),
          sectionTitle("Yesterday"),
          notificationItem(
            icon: Icons.email,
            iconColor: Colors.deepPurple,
            title: "35% Special Discount!",
            subtitle: "Special promotion only valid today",
          ),
          const Divider(thickness: 1, indent: 16, endIndent: 16),
          notificationItem(
            icon: Icons.person,
            iconColor: Colors.black,
            title: "Account Setup Successful!",
            subtitle: "Special promotion only valid today",
          ),
          notificationItem(
            icon: Icons.local_offer,
            iconColor: Colors.red,
            title: "Special Offer! 60% Off",
            subtitle: "Special offer for new account, valid until 20 Nov 2022",
          ),
          const Divider(thickness: 1, indent: 16, endIndent: 16),
          notificationItem(
            icon: Icons.credit_card,
            iconColor: Colors.orange,
            title: "Credit Card Connected",
            subtitle: "Special promotion only valid today",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
