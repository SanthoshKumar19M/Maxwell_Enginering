import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/service_controller.dart';
import 'package:maxwellengineering/models/service_model.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  ServiceListState createState() => ServiceListState();
}

class ServiceListState extends State<ServiceList> with SingleTickerProviderStateMixin {
  late Future<List<Service>> _serviceFuture;
  final ServiceController serviceController = ServiceController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Service> _services = [];
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _serviceFuture = _loadServices(); // Load services on init

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

  Future<List<Service>> _loadServices() async {
    return await serviceController.getAllServices();
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    Service service = _services[index];
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
          title: Text("Service No:  ${service.serviceNumber}", style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            "Machine: ${service.machine}\nVendor: ${service.vendor} \nStatus: ${service.status}",
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to service details page (implement navigation here)
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Service>>(
        future: _serviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No services found'));
          }

          _services = snapshot.data!;

          return SlideTransition(
            position: _slideAnimation,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _services.length,
              itemBuilder: _buildItem,
            ),
          );
        },
      ),
    );
  }
}
