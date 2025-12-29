// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_fashion/components/checkout_action.dart';
import 'package:open_fashion/components/custome-text.dart';
import 'package:open_fashion/components/footer_btn.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/components/label.dart';
import 'package:open_fashion/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:open_fashion/providers/cart_provider.dart';

class Chechout extends StatefulWidget {
  const Chechout({
    super.key,
  });

  @override
  State<Chechout> createState() => _ChechoutState();
}

class _ChechoutState extends State<Chechout> {
  Map<String, dynamic>? addressData;
  Map<String, dynamic>? paymentData;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().items;
    double totalPrice =
        cart.fold(0, (sum, item) => sum + item.price); // total cart price

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
            title: 'Checkout',
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header(title: 'Checkout'),
                Padding(
                  padding: const EdgeInsets.only(top: 17, bottom: 10),
                  child: Label(text: 'Shipping Adress'),
                ),
                if (addressData != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            CustomeText(
                              text:
                                  '${addressData!['firstName']} ${addressData!['lastName']}',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            // adress
                            CustomeText(
                              text: addressData!['adress'] ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ), // state
                            CustomeText(
                              text: addressData!['state'] ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ), // city
                            CustomeText(
                              text: addressData!['city'] ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                            // Phone
                            CustomeText(
                              text: addressData!['phoneNumber'] ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Ionicons.chevron_forward,
                          color: Colors.grey.shade900,
                        ),
                      ],
                    ),
                  ),
                if (addressData == null)
                  GestureDetector(
                    onTap: () async {
                      final result = await context.push(RouteNames.adress);

                      if (result != null && result is Map<String, dynamic>) {
                        setState(() {
                          addressData = result;
                        });
                      }
                    },
                    child: CheckoutAction(
                      mainText: 'Add shipping adress',
                      icon: Icons.add,
                    ),
                  ),

                if (paymentData == null)
                  GestureDetector(
                    onTap: () async {
                      final cardScreenData = await context.push(
                        RouteNames.addCard,
                      );
                      if (cardScreenData != null &&
                          cardScreenData is Map<String, dynamic>) {
                        setState(() {
                          paymentData = cardScreenData;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label(text: 'Payment Method'),
                          CheckoutAction(
                            mainText: 'select payment method',
                            icon: Ionicons.add,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (paymentData != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Divider(),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            context.push(RouteNames.addCard);
                          },
                          child: Row(
                            children: [
                              // card Logo
                              if (paymentData?['cardBrand'] == 'Master Card')
                                Image.asset(
                                  'assets/cover/masterCard.png',
                                  height: 50,
                                ),
                              if (paymentData?['cardBrand'] == 'Visa Card')
                                Image.asset(
                                  'assets/cover/visaCard.png',
                                  height: 50,
                                ),
                              Gap(20),
                              CustomeText(
                                text: (paymentData?['cardBrand'] +
                                        ' ' +
                                        'ending with' ??
                                    ''),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade200,
                              ),
                              CustomeText(
                                // "World"
                                text:
                                    '${paymentData?['cardNumber'].substring(paymentData?['cardNumber'].length - 5) ?? ''}',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade200,
                              ),
                              Spacer(),
                              Icon(Ionicons.chevron_forward),
                            ],
                          ),
                        ),
                        Gap(10),
                        Divider(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeText(
                  text: 'Est. Total',
                  fontSize: 18,
                  color: Colors.white,
                ),
                CustomeText(
                  text: '\$ ${totalPrice.toStringAsFixed(2)}',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Gap(24),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 500,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Close button
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          CustomeText(
                            text: 'PAYMENT SUCCESS',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.greenAccent,
                          ),

                          const Gap(35),

                          SvgPicture.asset(
                            'assets/svgs/success.svg',
                            color: Colors.greenAccent,
                            width: 80,
                          ),

                          const Gap(30),

                          CustomeText(
                            text: 'Your payment was successful',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),

                          const Gap(6),

                          CustomeText(
                            text: 'PAYMENT ID 15263541',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),

                          const Gap(25),

                          Container(
                            height: 1,
                            width: 200,
                            color: Colors.grey.shade800,
                          ),

                          const Gap(25),

                          CustomeText(
                            text: 'RATE YOUR PURCHASE',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),

                          const Gap(20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/sad.svg',
                                color: Colors.grey.shade500,
                                width: 38,
                              ),
                              const Gap(20),
                              SvgPicture.asset(
                                'assets/svgs/moderate.svg',
                                color: const Color.fromRGBO(168, 113, 90, 1),
                                width: 38,
                              ),
                              const Gap(20),
                              SvgPicture.asset(
                                'assets/svgs/happy.svg',
                                color: Colors.greenAccent,
                                width: 38,
                              ),
                            ],
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Back to home button
                              GestureDetector(
                                onTap: () {
                                  context.go(RouteNames.home);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: CustomeText(
                                    text: 'BACK TO HOME',
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              // Submit button
                              GestureDetector(
                                onTap: () {
                                  context.go(RouteNames.home);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 12,
                                  ),
                                  child: CustomeText(
                                    text: 'SUBMIT',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
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
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: FooterBtn(
                text: 'Place order',
                icon: Ionicons.bag_handle_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
