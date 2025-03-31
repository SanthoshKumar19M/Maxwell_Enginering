import 'package:flutter/material.dart';
import 'package:maxwellengineering/views/service_creation/service_creation.dart';
import 'package:maxwellengineering/views/service_creation/service_view.dart';
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
  // bool _reloadBody = false;
  // void _refreshBody() {
  //   setState(() {
  //     _reloadBody = !_reloadBody;
  //   });
  // }

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
              accountName: FutureBuilder<String?>(
                future: SharedPrefsHelper.getUserId(), // Fetch the user ID asynchronously
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  } else if (snapshot.hasError) {
                    return const Text("Error fetching user");
                  } else {
                    return Text(snapshot.data ?? "No User ID");
                  }
                },
              ),
              accountEmail: const Text("johndoe@example.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.precision_manufacturing_outlined),
              title: const Text("Machine Entry"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MachineEntryScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Service"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ServiceCreation()),
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text("Service"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const ServiceCreation()),
            //     ).then((_) {
            //       _refreshBody(); // Refresh dashboard when returning
            //     });
            //   },
            // ),

            // ListTile(
            //   leading: const Icon(Icons.build),
            //   title: const Text("Service View"),
            //   onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const ServiceList()),
            //   ),
            // ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Employee"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmployeeCreation()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Employee View"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmployeeListScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text("Vendor"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VendorCreation()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.store_mall_directory),
              title: const Text("Vendor View"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VendorListScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text("Tax"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaxCreation()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.money_off),
              title: const Text("Tax View"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaxView()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text("Unit"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UnitCreation()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_customize),
              title: const Text("Unit View"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UnitView()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Category"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryCreation()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: const Text("Category View"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryView()),
              ),
            ),
          ],
        ),
      ),
      body: const ServiceList(),
    );
  }
}
