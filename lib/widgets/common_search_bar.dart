import 'package:flutter/material.dart';

class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const CommonSearchBar({
    super.key,
    this.hintText = "Type your requirement here . . .",
    this.onSearchChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: onSearchChanged,
        onTap: onTap,
        readOnly: readOnly,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image.asset(
                'assets/search_image.png',
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(25),
          //   // borderSide: BorderSide.none,

          //   // borderSide: const BorderSide(color: Color(0x1F1F1F0F), width: 2),
          //   // Border color and width
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xffE8E7EA), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xffE8E7EA), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xffE8E7EA), width: 2),
          ),
        ),
      ),
    );
  }
}
