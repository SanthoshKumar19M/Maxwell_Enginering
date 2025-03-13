import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwellengineering/controllers/tax_contoller.dart';
import 'package:maxwellengineering/controllers/unit_contoller.dart';
import 'package:maxwellengineering/core/theme.dart';
import 'package:maxwellengineering/models/tax_model.dart';
import 'package:maxwellengineering/models/unit_model.dart';
import '../../utils/textformfield_decorattion.dart';

class UnitCreation extends StatefulWidget {
  const UnitCreation({super.key});

  @override
  UnitCreationState createState() => UnitCreationState();
}

class UnitCreationState extends State<UnitCreation> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _groupNameTextController = TextEditingController();
  final UnitController unitController = UnitController();

  Future<void> addUnit(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await unitController.addUnit(
        Unit(
          unitName: _groupNameTextController.text,
        ),
        context,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unit added successfully!')),
      );

      // Optionally, clear the form fields after adding the employee
      _groupNameTextController.clear();
    } catch (error) {
      // Handle error gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Unit Details: $error')),
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
      appBar: AppBar(title: const Text('Create Unit')),
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
                                    controller: _groupNameTextController,
                                    decoration: InputDecorations.textFieldDecoration(
                                      labelText: "Unit Name",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Please enter a Unit Name";
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
                                    addUnit(context);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  AppTheme.primaryColor,
                                )),
                                child: const Text(
                                  'Add Unit',
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
