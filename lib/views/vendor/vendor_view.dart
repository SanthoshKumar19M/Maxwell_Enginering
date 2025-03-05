import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/vendor_controller.dart';
import 'package:maxwellengineering/models/vendor_model.dart';

class VendorListScreen extends StatefulWidget {
  const VendorListScreen({super.key});

  @override
  VendorListScreenState createState() => VendorListScreenState();
}

class VendorListScreenState extends State<VendorListScreen> with SingleTickerProviderStateMixin {
  late Future<List<Vendor>> _vendorFuture;
  final VendorController vendorController = VendorController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Vendor> _vendors = [];
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _listBuilt = false; // Add a flag

  @override
  void initState() {
    super.initState();
    _loadVendors();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadVendors() async {
    _vendorFuture = vendorController.getAllVendors();
    _vendorFuture.then((vendors) {
      if (mounted) {
        setState(() {
          _vendors = vendors;
          _listBuilt = true; // Set flag to true
        });
      }
    });
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    Vendor vendor = _vendors[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(animation),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(vendor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Vendor ID: ${vendor.vendorId}\nEmail: ${vendor.mail}"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor List')),
      body: Stack(
        children: [
          FutureBuilder<List<Vendor>>(
            future: _vendorFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No vendors found'));
              }

              if (_vendors.isEmpty) {
                return const Center(child: Text('No vendors found'));
              }

              if (_listBuilt) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _vendors.length,
                    itemBuilder: _buildItem,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator()); // show loading until the list is built.
              }
            },
          ),
          AnimatedOpacity(
            opacity: _vendors.isEmpty && _vendorFuture.toString() != "Instance of '_Future<List<Vendor>>'" ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
