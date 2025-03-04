import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwellengineering/controllers/vendor_controller.dart';
import 'package:maxwellengineering/core/theme.dart';
import 'package:maxwellengineering/models/vendor_model.dart';
import '../../utils/textformfield_decorattion.dart';

class VendorCreation extends StatefulWidget {
  const VendorCreation({super.key});

  @override
  VendorCreationState createState() => VendorCreationState();
}

class VendorCreationState extends State<VendorCreation> with SingleTickerProviderStateMixin {
  // Add mixin for AnimationController
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _GSTController = TextEditingController();
  final TextEditingController billingAddressController = TextEditingController();
  final TextEditingController shippingAddressController = TextEditingController();
  final VendorController vendorController = VendorController();

  Future<void> addVendor(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await vendorController.addVendor(
        Vendor(
          name: _nameController.text,
          mail: _mailController.text,
          mobile: _mobileController.text,
          billingAddress: billingAddressController.text,
          shippingAddress: shippingAddressController.text,
          gstNumber: _GSTController.text,
        ),
        context,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vendor added successfully!')),
      );

      _nameController.clear();
      _GSTController.clear();
      _mailController.clear();
      _mobileController.clear();
      billingAddressController.clear();
      shippingAddressController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Vendor: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  late AnimationController _animationController; // Declare AnimationController
  late Animation<Offset> _slideAnimation; // Declare SlideAnimation

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
      appBar: AppBar(title: const Text('Create Vendor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: isLoading ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              if (!isLoading) // Show form only when not loading
                SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter a name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _GSTController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "GST Number",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter an GST Number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _mailController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter an email";
                                  }
                                  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                                  if (!emailRegex.hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _mobileController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Mobile",
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter a mobile number";
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return "Only numbers are allowed";
                                  }
                                  if (value.length != 10) {
                                    return "Mobile number must be 10 digits";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: billingAddressController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Billing Address",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter Billing Address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: shippingAddressController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Shipping Address",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter Shipping Address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
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
                                addVendor(context);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                            ),
                            child: const Text(
                              'Add Vendor',
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
