import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/footer_btn.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/components/text_input.dart';

class Adress extends StatefulWidget {
  const Adress({super.key});

  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _adress;
  late String _city;
  late String _state;
  late String _zipCode;
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Ionicons.chevron_back_circle,
              color: Colors.white,
              size: 35,
            ),
          ),
          backgroundColor: Colors.black,
          title: Header(
            title: 'Add shipping adress',
          )),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  TextInput(
                    text: 'First Name',
                    validator: (value) => check('First Name', value),
                    screenWidthFactor: 0.42,
                    onSaved: (value) => _firstName = value!,
                  ),
                  Gap(20),
                  TextInput(
                    text: 'Last Name',
                    validator: (value) => check('Last Name', value),
                    screenWidthFactor: 0.42,
                    onSaved: (value) => _lastName = value!,
                  ),
                ],
              ),
            ),
            TextInput(
              text: 'Adress',
              validator: (value) => check('Adress', value),
              screenWidthFactor: 0.9,
              onSaved: (value) => _adress = value!,
            ),
            Gap(20),
            TextInput(
              text: 'City',
              validator: (value) => check('City', value),
              screenWidthFactor: 0.9,
              onSaved: (value) => _city = value!,
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  TextInput(
                    text: 'State',
                    validator: (value) => check('State', value),
                    screenWidthFactor: 0.42,
                    onSaved: (value) => _state = value!,
                  ),
                  Gap(20),
                  TextInput(
                    text: 'ZIP code',
                    validator: (value) => check('ZIP code', value),
                    screenWidthFactor: 0.42,
                    onSaved: (value) => _zipCode = value!,
                  ),
                ],
              ),
            ),
            Gap(20),
            TextInput(
              text: 'Phone number',
              validator: (value) => check('Phone number', value),
              keyboardType: TextInputType.phone,
              screenWidthFactor: 0.9,
              onSaved: (value) => _phoneNumber = value!,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  context.pop({
                    'firstName': _firstName,
                    'lastName': _lastName,
                    'adress': _adress,
                    'city': _city,
                    'state': _state,
                    'zipCode': _zipCode,
                    'phoneNumber': _phoneNumber,
                  });
                } else {
                  return;
                }
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: FooterBtn(text: 'Add Address')),
            ),
          ],
        ),
      ),
    );
  }
}

String? check(String label, String? value) {
  if (value == null || value.trim().isEmpty) {
    return '$label is required';
  } else {
    return null;
  }
}
