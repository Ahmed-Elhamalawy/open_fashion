import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  //properties
  final String text;
  final bool? ispassword;
  final TextEditingController? controller;
  final double? screenWidthFactor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

//constructor
  const CustomFormTextField({
    super.key,
    required this.text,
    this.screenWidthFactor,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.ispassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (screenWidthFactor ?? 1),
      child: TextFormField(
        obscureText: ispassword ?? false,
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,

          labelStyle: TextStyle(color: Colors.grey.shade200),
          filled: false,

          // Idle State
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),

          // Active State
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),

          // Error State
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),

          // Focused Error State
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
      ),
    );
  }
}
