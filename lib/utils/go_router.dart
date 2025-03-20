import 'package:go_router/go_router.dart';
import 'package:maxwellengineering/utils/share_preferences_helper.dart';
import '../views/dashboard/dashboard.dart';
import '../views/employee/employee_creation.dart';
import '../views/employee/employee_view.dart';
import '../views/loginscreen/login_screen.dart';
import '../views/vendor/vendor_creation.dart';
import '../views/vendor/vendor_view.dart';
import '../views/tax_master/tax_creation.dart';

final GoRouter router = GoRouter(
  // initialLocation:   SharedPrefsHelper.isLoggedIn() ? '/' : '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    // Uncomment if we have a settings screen
    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsScreen(),
    // ),
    GoRoute(
      path: '/add-employee',
      builder: (context, state) => const EmployeeCreation(),
    ),
    GoRoute(
      path: '/view-employee',
      builder: (context, state) => const EmployeeListScreen(),
    ),
    // GoRoute(
    //   path: '/edit-employee/:id',
    //   builder: (context, state) {
    //     final String? employeeId = state.pathParameters['id'];
    //     // return EmployeeCreation(employeeId: employeeId);
    //   },
    // ),
    GoRoute(
      path: '/view-vendor',
      builder: (context, state) => const VendorListScreen(),
    ),
    GoRoute(
      path: '/add-vendor',
      builder: (context, state) => const VendorCreation(),
    ),
    // GoRoute(
    //   path: '/edit-vendor/:id',
    //   builder: (context, state) {
    //     final String? vendorId = state.pathParameters['id'];
    //     // return VendorCreation(vendorId: vendorId);
    //   },
    // ),
    GoRoute(
      path: '/view-tax',
      builder: (context, state) => const TaxCreation(),
    ),
  ],
);
