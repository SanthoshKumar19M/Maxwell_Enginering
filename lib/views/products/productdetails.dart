import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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

  TextEditingController location = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController numberOfPorts = TextEditingController();
  TextEditingController addtionalDetails = TextEditingController();

  @override
  void initState() {
    super.initState();
    location = TextEditingController();
    name = TextEditingController();
    numberOfPorts = TextEditingController();
    addtionalDetails = TextEditingController();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteProduct(String docId) async {
    await _firestore.collection('products').doc(docId).delete();
    if (kDebugMode) {
      print("product deleted: $docId");
    }
    setState(() {
      // SnackBarFunction().snackBarFunc("Product deleted successfully", context);
    });
  }

  Future<void> updateProduct(String docId, Map<String, dynamic> newData) async {
    await _firestore.collection('products').doc(docId).update(newData);
    if (kDebugMode) {
      print("product updated: $docId");
    }
    setState(() {
      // SnackBarFunction().snackBarFunc("Product updated successfully", context);
    });
  }

  void showUpdateDialog(BuildContext context, String docId, Map<String, dynamic> currentData) {
    final mrp = TextEditingController(text: currentData['mrp']);
    final name = TextEditingController(text: currentData['name']);
    final sellingPrice = TextEditingController(text: currentData['sellingPrice']);
    final hsn = TextEditingController(text: currentData['hsn']);
    final tax = TextEditingController(text: currentData['tax']);
    final qty = TextEditingController(text: currentData['qty']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Product"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Collect updated data
              final newData = {
                'mrp': mrp.text,
                'name': name.text,
                'qty': qty.text,
                'hsn': hsn.text,
                'tax': tax.text,
                'sellingPrice': sellingPrice.text,
              };
              await updateProduct(docId, newData);
              Navigator.of(context).pop();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  var stationDocId = "";
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search TextField
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Search",
                        prefixIcon: const Icon(Icons.search),
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
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Products found"));
                }

                // Filter station based on search query
                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final productData = doc.data() as Map<String, dynamic>;
                  final mrp = productData['mrp']?.toLowerCase() ?? "";
                  final name = productData['name']?.toLowerCase() ?? "";
                  final sellingPrice = productData['sellingPrice']?.toLowerCase() ?? "";
                  final hsn = productData['hsn']?.toLowerCase() ?? "";
                  final tax = productData['tax']?.toLowerCase() ?? "";
                  return mrp.contains(searchQuery) || name.contains(searchQuery) || sellingPrice.contains(searchQuery) || hsn.contains(searchQuery) || tax.contains(searchQuery);
                }).toList();

                if (filteredDocs.isEmpty) {
                  return const Center(child: Text("No Products found"));
                }

                // Map Firestore documents to a ListView
                return MediaQuery.of(context).size.width < 500
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
                          itemCount: filteredDocs.length,
                          itemBuilder: (context, index) {
                            // Existing code for building the list items
                            final DocumentSnapshot stationDoc = filteredDocs[index];
                            final productData = stationDoc.data() as Map<String, dynamic>;
                            final docId = stationDoc.id;

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                              ),
                              elevation: 4, // Shadow elevation
                              color: Colors.white, // Card background color
                              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name: ${productData['name'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'MRP: ${productData['mrp'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Selling Price: ${productData['sellingPrice'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'HSN: ${productData['hsn'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Qty: ${productData['qty'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Tax: ${productData['tax'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => showUpdateDialog(context, docId, productData),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.blueAccent.withOpacity(0.1),
                                            radius: 20,
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              color: Colors.blueAccent,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12.0),
                                          child: InkWell(
                                            onTap: () async {
                                              bool confirm = await showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: const Text("Confirmation"),
                                                  content: Text(
                                                    "Are you sure you want to delete this Product: ${productData['name']}?",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(false),
                                                      child: const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(true),
                                                      child: const Text("Delete"),
                                                    ),
                                                  ],
                                                ),
                                              );

                                              if (confirm) {
                                                await deleteProduct(docId);
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blueAccent.withOpacity(0.1),
                                              radius: 20,
                                              child: const Icon(
                                                Icons.delete_outlined,
                                                color: Colors.redAccent,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'MRP',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Selling Price',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'HSN',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Tax',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Quantity',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actions',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                          ],
                          rows: filteredDocs.map((stationDoc) {
                            final productData = stationDoc.data() as Map<String, dynamic>;
                            final docId = stationDoc.id;

                            return DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) return Colors.blue.shade50;
                                  return Colors.grey.shade200; // Apply background color for row alternation
                                },
                              ),
                              cells: [
                                DataCell(Text(
                                  productData['name'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(Text(
                                  productData['mrp'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(Text(
                                  productData['sellingPrice'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(Text(
                                  productData['hsn'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(Text(
                                  productData['tax'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(Text(
                                  productData['qty'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      InkWell(
                                        child: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
                                        onTap: () => showUpdateDialog(context, docId, productData),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            bool confirm = await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text("Confirmation"),
                                                content: Text("Are you sure you want to delete this product: ${productData['name']}?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(true),
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (confirm) {
                                              await deleteProduct(docId);
                                            }
                                          },
                                          child: const Icon(Icons.delete_outlined, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          dividerThickness: 1,
                          headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
                          headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          columnSpacing: 24,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
