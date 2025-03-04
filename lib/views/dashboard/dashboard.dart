import 'package:flutter/material.dart';
import 'package:maxwellengineering/views/employee/employee_view.dart';
import 'package:maxwellengineering/views/vendor/vendor_create_view.dart';
import 'package:maxwellengineering/views/vendor/vendor_view.dart';

import '../employee/employee_create_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification click
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Employee"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeCreateView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Employee View"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Vendor"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorCreation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Vendor View"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorListScreen()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Welcome to Dashboard",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
