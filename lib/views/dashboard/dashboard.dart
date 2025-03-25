import 'package:flutter/material.dart';
import '../../utils/share_preferences_helper.dart';
import '../../views/categories_master/category_creation.dart';
import '../../views/categories_master/category_view.dart';
import '../../views/employee/employee_view.dart';
import '../../views/machine_screen/add_machine.dart';
import '../../views/tax_master/tax_creation.dart';
import '../../views/tax_master/tax_view.dart';
import '../../views/unit_master/unit_creation.dart';
import '../../views/unit_master/unit_view.dart';
import '../../views/vendor/vendor_creation.dart';
import '../../views/vendor/vendor_view.dart';

import '../employee/employee_creation.dart';

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
            UserAccountsDrawerHeader(
              accountName: Text(SharedPrefsHelper.getUserId().toString()),
              accountEmail: const Text("johndoe@example.com"),
              currentAccountPicture: const CircleAvatar(
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
              leading: const Icon(Icons.precision_manufacturing_outlined),
              title: const Text("machine entry"),
              onTap: () {
                // Navigate to settings
                Navigator.push(context, MaterialPageRoute(builder: (context) => MachineEntryScreen()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeCreation()));
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
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Tax"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TaxCreation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Tax View"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TaxView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Unit"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitCreation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Unit View"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Category"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryCreation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Category View"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryView()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service Details",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Machine NO ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "0011",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Service Incharge",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Sandy",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "In - Progress",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Last Serviced At",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          DateTime.now().toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
