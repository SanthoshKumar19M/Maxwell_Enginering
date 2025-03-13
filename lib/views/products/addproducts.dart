import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwellengineering/views/employee/employee_creation.dart';
import 'package:maxwellengineering/views/products/productdetails.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
    required this.close,
  });
  final Function() close;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double headingFontSize = 16;
  double subHeadingFontSize = 14;
  double bodyFontSize = 12;

  TextStyle headingTextStyle(double fontSize, FontWeight weight) {
    return TextStyle(fontSize: fontSize, fontWeight: weight);
  }

  Padding inlinePadding() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
    );
  }

  TextEditingController mrp = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController hsn = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController qty = TextEditingController();

  @override
  void initState() {
    super.initState();
    mrp = TextEditingController();
    name = TextEditingController();
    hsn = TextEditingController();
    sellingPrice = TextEditingController();
    qty = TextEditingController();
    tax = TextEditingController();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> addProductDatas = {};
  Future<void> addProductData() async {
    setState(() {
      isLoading = true;
    });

    await _firestore.collection('products').add(addProductDatas);
    if (kDebugMode) {
      print("Product added!");
    }
    setState(() {
      isLoading = false;
    });
    widget.close.call();

    setState(() {
      //    SnackBarFunction().snackBarFunc("Product added successfully", context);
    });

    /// widget.closeAddCustomer.call();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Products()));
                },
                child: const Icon(Icons.view_agenda)),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeCreation()));
                },
                child: const Icon(Icons.person)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          if (isLoading == false)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add Product",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Column(
                    children: [
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon: const Icon(Icons.label_outline_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // You can adjust the border radius here
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Customize the color and width for focused state
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Customize the color and width for enabled state
                          ),
                        ),
                        controller: name,
                        textAlign: TextAlign.start,
                      ),
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "MRP",
                          prefixIcon: const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Adjust border radius
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Focused state
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Enabled state
                          ),
                        ),
                        controller: mrp,
                        textAlign: TextAlign.start,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allows double values
                        ],
                      ),
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Selling Price",
                          prefixIcon: const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Adjust border radius
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Focused state
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Enabled state
                          ),
                        ),
                        controller: sellingPrice,
                        textAlign: TextAlign.start,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allows double values
                        ],
                      ),
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "HSN",
                          prefixIcon: const Icon(Icons.numbers_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // You can adjust the border radius here
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Customize the color and width for focused state
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Customize the color and width for enabled state
                          ),
                        ),
                        controller: hsn,
                        textAlign: TextAlign.start,
                      ),
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Tax",
                          prefixIcon: const Icon(Icons.percent),
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
                        controller: tax,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}$')), // Allows up to two digits only
                        ],
                      ),
                      inlinePadding(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Qutantity",
                          prefixIcon: const Icon(Icons.add),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // You can adjust the border radius here
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Customize the color and width for focused state
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Customize the color and width for enabled state
                          ),
                        ),
                        controller: qty,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}$')), // Allows up to two digits only
                        ],
                        textAlign: TextAlign.start,
                      ),
                      inlinePadding(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.close.call();
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                addProductDatas = {
                                  'mrp': mrp.text,
                                  'name': name.text,
                                  'qty': qty.text,
                                  'hsn': hsn.text,
                                  'tax': tax.text,
                                  'sellingPrice': sellingPrice.text,
                                };
                              });
                              addProductData();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
                              iconColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text(
                              "Add Product",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          if (isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ]),
      ),
    );
  }
}
