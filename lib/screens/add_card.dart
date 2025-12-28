import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/footer_btn.dart';
import 'package:open_fashion/components/header.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CreditCardBrand? cardBrand; // Changed from 'other' to 'unknown'

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        title: Header(title: 'Add Payment Card'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CreditCardWidget(
            isHolderNameVisible: true,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            // cardType: CardType.visa,
            showBackView: isCvvFocused,
            onCreditCardWidgetChange: (CreditCardBrand brand) {
              // Schedule setState for after the current build completes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    cardBrand = brand;
                  });
                }
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardForm(
                    formKey: formKey,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: onCreditCardModelChange,
                    inputConfiguration: const InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          labelStyle: TextStyle(color: Colors.white)),
                      expiryDateDecoration: InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      cvvCodeDecoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: 'XXX',
                          labelStyle: TextStyle(color: Colors.white)),
                      cardHolderDecoration: InputDecoration(
                          labelText: 'Name on Card',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Card added successfully!')),
                );
                context.pop({
                  'cardNumber': cardNumber,
                  'expiryDate': expiryDate,
                  'cardHolderName': cardHolderName,
                  'cvvCode': cvvCode,
                  'cardBrand': detectCardType(cardNumber),
                });
              }
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: FooterBtn(text: 'Add Card')),
          ),
        ],
      ),
    );
  }
}

String detectCardType(String cardNumber) {
  // Remove spaces and dashes
  String cleanNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

  // Return unknown if empty
  if (cleanNumber.isEmpty) {
    return 'unknown';
  }

  // Visa: starts with 4
  if (cleanNumber.startsWith('4')) {
    return 'Visa Card';
  }

  // Mastercard: starts with 51-55 or 2221-2720
  if (RegExp(r'^5[1-5]').hasMatch(cleanNumber) ||
      RegExp(
        r'^2(22[1-9]|2[3-9][0-9]|[3-6][0-9]{2}|7[01][0-9]|720)',
      ).hasMatch(cleanNumber)) {
    return 'Master Card';
  }

  // American Express: starts with 34 or 37
  if (RegExp(r'^3[47]').hasMatch(cleanNumber)) {
    return 'amex';
  }

  // Discover: starts with 6011, 622126-622925, 644-649, or 65
  if (RegExp(
    r'^6011|^622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[01][0-9]|92[0-5])|^64[4-9]|^65',
  ).hasMatch(cleanNumber)) {
    return 'discover';
  }

  // Diners Club: starts with 300-305, 36, or 38
  if (RegExp(r'^3(0[0-5]|[68])').hasMatch(cleanNumber)) {
    return 'dinersclub';
  }

  // JCB: starts with 2131, 1800, or 35
  if (RegExp(r'^(2131|1800|35)').hasMatch(cleanNumber)) {
    return 'jcb';
  }

  // UnionPay: starts with 62
  if (cleanNumber.startsWith('62')) {
    return 'unionpay';
  }

  return 'unknown';
}
