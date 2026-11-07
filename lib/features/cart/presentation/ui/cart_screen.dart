import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/cart/presentation/ui/widgets/cart_products_list.dart';
import 'package:e_commerce_app/features/cart/presentation/ui/widgets/checkout_section.dart'; 
import 'package:e_commerce_app/features/cart/presentation/ui/widgets/empty_cart_widget.dart';
import 'package:e_commerce_app/features/paymob_service/paymob_webview.dart';
import 'package:e_commerce_app/features/paymob_service/presentation/ui/payment_screen.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  Future<void> initiatePaymobPayment({
    required BuildContext context,
    required double amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final cartCubit = context.read<CartCubit>();

    final url = Uri.parse('https://paymob-mock-backend.vercel.app/api/create-payment');

    try {
      print("Sending request to: $url"); 
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
        }),
      );

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        String paymentKey = data['payment_key'];
        String paymentUrl = "https://accept.paymob.com/api/acceptance/iframes/1093635?payment_token=$paymentKey";
        
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (webViewContext) => PaymobWebview(
                paymentUrl: paymentUrl,
                onPaymentFinished: () {
                  cartCubit.emptyCart(); 
                },
              ),
            ),
          );
        }
      } else {
        print("Error: ${data['message']}");
      }
    } catch (e) {
      print("Network Error: $e");
    }
  }

  void _showCheckoutBottomSheet(BuildContext context, double total) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return PaymentScreen(
          total: total,
          onProceedToPayment: ({
            required amount,
            required firstName,
            required lastName,
            required email,
            required phone,
          }) {
            initiatePaymobPayment(
              context: context, 
              amount: amount,
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.cartTitle.tr()), centerTitle: true),
      body: BlocConsumer<CartCubit, CartState>(
        buildWhen: (previous, current) =>
            current is CartLoading || current is CartUpdated,
        listener: (context, state) {
          if (state is CartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.orderSuccess.tr()),
                backgroundColor: AppColor.containercolor,
              ),
            );
          } else if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColor.containercolor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartUpdated) {
            if (state.items.isEmpty) {
              return const EmptyCartWidget();
            }
            return Column(
              children: [
                Expanded(
                  child: CartProductsList(items: state.items),
                ),
                CheckoutSection(
                  total: state.total,
                  onCheckoutPressed: () {
                    _showCheckoutBottomSheet(context, state.total);
                  },
                ),
              ],
            );
          }
          return const EmptyCartWidget();
        },
      ),
    );
  }
}