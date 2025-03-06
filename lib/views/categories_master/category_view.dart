import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/category_controller.dart';
import 'package:maxwellengineering/models/category_model.dart';
import 'package:maxwellengineering/models/category_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  late Future<List<Categories>> _categoryFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = categoryController.getAllCategorieses();
  }

  final CategoriesController categoryController = CategoriesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories List')),
      body: FutureBuilder<List<Categories>>(
        future: _categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categoryes found')); // No data message
          }

          List<Categories> categoryes = snapshot.data!;

          return ListView.builder(
            itemCount: categoryes.length,
            itemBuilder: (context, index) {
              Categories category = categoryes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(category.categoryName.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    // MaterialPageRoute(
                    //   builder: (context) => EmployeeDetailsScreen(
                    //     name: employee.name,
                    //     employeeId: employee.employeeId,
                    //     email: employee.mail,
                    //     mobile: employee.mobile,
                    //     addressLine1: employee.addressLine1,
                    //     addressLine2: employee.addressLine2,
                    //   ),
                    // ),
                    // );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
