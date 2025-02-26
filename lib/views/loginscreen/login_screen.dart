import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:maxwellengineering/views/addproducts.dart';

import '../dashboard/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double headingFontSize = 16;
  double subHeadingFontSize = 14;
  double bodyFontSize = 12;

  bool isLoading = false;
  TextStyle headingTextStyle(double fontSize, FontWeight weight) {
    return TextStyle(fontSize: fontSize, fontWeight: weight);
  }

  Padding inlinePadding() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
    );
  }

  final _auth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  void storeUserLoginDetails() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String email = user.email ?? '';
      String displayName = user.displayName ?? '';
      DateTime now = DateTime.now();
      String loginTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // Create or update user data in Firestore
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'displayName': displayName,
        'lastLogin': loginTime,
      }, SetOptions(merge: true)); // SetOptions(merge: true) allows updating fields without overwriting the whole document
    }
  }

  String? token;
  Future<void> _login() async {
    token = null;
    setState(() {
      isLoading = true;
    });
    // Trim email and password inputs
    final email = userNameController.text.trim();
    final password = passwordController.text.trim();

    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      print("Email and password must not be empty");
      return setState(() {});
    }

    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve UID and token after successful login
      String? uid = userCredential.user?.uid;
      token = await userCredential.user?.getIdToken();

      if (token != null) {
        // Store token securely
        await _storage.write(key: 'auth_token', value: token);
        print("Login successful. Token stored securely.");
        setState(() {});
        storeUserLoginDetails();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProduct(
                      close: () {},
                    )));
        setState(() {
          isLoading = false;
        });
      }

      if (uid != null) {
        print("User UID: $uid");
      }
    } on FirebaseAuthException catch (e) {
      // Specific error handling for FirebaseAuth errors
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Incorrect password.");
      } else if (e.code == 'invalid-email') {
        print("The email address is not valid.");
      } else if (e.code == 'user-disabled') {
        print("User account has been disabled.");
      } else {
        print("Error: ${e.message}");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // General error handling
      print("An error occurred: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  final _formKey = GlobalKey<FormState>(); // Declare the form key

  bool visibility = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (isLoading) const Center(child: CircularProgressIndicator()),
            if (!isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey, // Assign the form key here
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 5)),
                                    Text(
                                      "Please sign in to continue.",
                                      style: headingTextStyle(
                                        14,
                                        FontWeight.w400,
                                      ),
                                    ),
                                    inlinePadding(),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        label: const Text("EMAIL"),
                                        prefixIcon: const Icon(Icons.email_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                        ),
                                      ),
                                      controller: userNameController,
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email';
                                        }
                                        final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                                        if (!emailRegExp.hasMatch(value)) {
                                          return 'Enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    inlinePadding(),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        label: const Text("PASSWORD"),
                                        prefixIcon: const Icon(Icons.lock_outlined),
                                        suffix: InkWell(
                                          onTap: toggleVisibility,
                                          child: Icon(
                                            visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                        ),
                                      ),
                                      obscureText: visibility,
                                      controller: passwordController,
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    inlinePadding(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!.validate()) {
                                                _login();
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
                                              iconColor: WidgetStateProperty.all(Colors.white),
                                            ),
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "LOGIN",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 15.0),
                                                  child: Icon(Icons.arrow_forward),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
