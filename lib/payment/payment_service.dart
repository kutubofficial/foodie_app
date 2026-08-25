import 'package:flutter/rendering.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  PaymentService({required this.onSuccess, required this.onError}) : _razorpay = Razorpay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  final Razorpay _razorpay;
  final void Function(PaymentSuccessResponse response) onSuccess;
  final void Function(PaymentFailureResponse response) onError;

  static const String _testKeyId = 'rzp_test_TLHgwReVCRQvwL';

  void openCheckout({
    required double amountInRupees,
    required String description,
    String? userName,
    String? userEmail,
    String? userContact,
  }) {
    final options = {
      'key': _testKeyId,
      'amount': (amountInRupees * 100).round(),
      'name': 'Foodie',
      'description': description,
      'prefill': {
        'contact': userContact ?? '',
        'email': userEmail ?? '',
        'name': userName ?? '',
      },
      'theme': {
        'color': '#FF6B35',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrintPaymentError(e);
      onError(PaymentFailureResponse(-1, e.toString(), null));
    }
  }

  void _handleSuccess(PaymentSuccessResponse response) => onSuccess(response);

  // void _handleError(PaymentFailureResponse response) => onError(response);
  void _handleError(PaymentFailureResponse response) {
  debugPrint('Razorpay error code: ${response.code}');
  debugPrint('Razorpay error message: ${response.message}');
  onError(response);
}

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  void debugPrintPaymentError(Object error) {
    // ignore: avoid_print
    print('Razorpay checkout error: $error');
  }

  void dispose() {
    _razorpay.clear();
  }
}