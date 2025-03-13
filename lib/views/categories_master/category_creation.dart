import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwellengineering/controllers/category_controller.dart';
import 'package:maxwellengineering/controllers/tax_contoller.dart';
import 'package:maxwellengineering/core/theme.dart';
import 'package:maxwellengineering/models/category_model.dart';
import 'package:maxwellengineering/models/tax_model.dart';
import '../../utils/textformfield_decorattion.dart';

class CategoryCreation extends StatefulWidget {
  const CategoryCreation({super.key});

  @override
  CategoryCreationState createState() => CategoryCreationState();
}

class CategoryCreationState extends State<CategoryCreation> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _categoryNameController = TextEditingController();
  final CategoriesController categoryController = CategoriesController();

  Future<void> addCategories(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await categoryController.addCategories(
        Categories(
          categoryName: (_categoryNameController.text),
        ),
        context,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categories added successfully!')),
      );

      // Optionally, clear the form fields after adding the employee
      _categoryNameController.clear();
    } catch (error) {
      // Handle error gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Categories Details: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  late AnimationController _animationController; // Declare AnimationController
  late Animation<Offset> _slideAnimation; // Declare SlideAnimation
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward(); // Start the slide-in animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              isLoading
                  ? AnimatedOpacity(
                      opacity: isLoading ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _categoryNameController,
                                    decoration: InputDecorations.textFieldDecoration(
                                      labelText: "Category Name",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Please enter a Categories Name";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    addCategories(context);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  AppTheme.primaryColor,
                                )),
                                child: const Text(
                                  'Add Category',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
