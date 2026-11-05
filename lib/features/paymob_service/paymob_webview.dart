import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymobWebview extends StatefulWidget {
  final String paymentUrl;
  final VoidCallback onPaymentFinished;

  const PaymobWebview({
    super.key,
    required this.paymentUrl,
    required this.onPaymentFinished,
  });

  @override
  State<PaymobWebview> createState() => _PaymobWebviewState();
}

class _PaymobWebviewState extends State<PaymobWebview> {
  bool _isHandled = false; 

  void _handlePaymentSuccess() {
    if (_isHandled) return;
    _isHandled = true;
    print("Payment Approved & Handled!");

    widget.onPaymentFinished();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  void _handlePaymentFailure() {
    if (_isHandled) return;
    _isHandled = true;
    print("Payment Declined/Failed!");

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment"), centerTitle: true),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
        onLoadStop: (controller, url) async {
          if (url == null) return;
          String urlString = url.toString();

          if (urlString.contains("success=true") || urlString.contains("txn_response_code=APPROVED")) {
            _handlePaymentSuccess();
          } else if (urlString.contains("success=false") || urlString.contains("txn_response_code=DECLINED")) {
            _handlePaymentFailure();
          }
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) async {
          if (url == null) return;
          String urlString = url.toString();

          if (urlString.contains("success=true") || urlString.contains("txn_response_code=APPROVED")) {
            _handlePaymentSuccess();
          } else if (urlString.contains("success=false") || urlString.contains("txn_response_code=DECLINED")) {
            _handlePaymentFailure();
          }
        },
      ),
    );
  }
}