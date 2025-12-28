import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.text,
    this.screenWidthFactor,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.onChanged,
  });

  final String text;
  final double? screenWidthFactor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (screenWidthFactor ?? 1),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
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
