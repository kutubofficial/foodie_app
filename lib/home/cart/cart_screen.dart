import 'package:flutter/material.dart';
import 'package:foodie/home/cart/order_success_screen.dart';
import 'package:foodie/payment/payment_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartItemInput {
  const CartItemInput({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final double price;
  final String imagePath;
}

class _CartLine {
  // ignore: unused_element_parameter
  _CartLine({required this.name, required this.price, required this.imagePath, this.qty = 1});
  final String name;
  final double price;
  final String imagePath;
  int qty;
}

enum _PaymentMethod { cash, creditCard, upi }

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    this.restaurantName,
    this.initialItem,
  });

  final String? restaurantName;
  final CartItemInput? initialItem;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final List<_CartLine> _cartItems;
  final TextEditingController _voucherController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  _PaymentMethod _selectedPayment = _PaymentMethod.cash;
  bool _showPaymentOptions = false;
  bool _isProcessingPayment = false;
  late final PaymentService _paymentService;

  static const double _deliveryFee = 50.0;
  static const double _platformFee = 9.90;
  static const double _vatRate = 0.165;


  static const Color _pageBackgroundPink = Color(0xFFFCF1EC);

  @override
  void initState() {
    super.initState();
    _cartItems = widget.initialItem == null
        ? []: [
            _CartLine(
              name: widget.initialItem!.name,
              price: widget.initialItem!.price,
              imagePath: widget.initialItem!.imagePath,),
            ];
            _paymentService = PaymentService(onSuccess: _onPaymentSuccess, onError: _onPaymentError);
  }

  void _onPlaceOrderPressed() {
    if (_selectedPayment == _PaymentMethod.cash) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),);
      return;
    }
 
    setState(() => _isProcessingPayment = true);
    final itemNames = _cartItems.map((item) => item.name).join(', ');
    _paymentService.openCheckout(
      amountInRupees: _total,
      description: itemNames,
    );
  }

   void _onPaymentSuccess(PaymentSuccessResponse response) {
    setState(() => _isProcessingPayment = false);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),);
  }

 void _onPaymentError(PaymentFailureResponse response) {
    setState(() => _isProcessingPayment = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message ?? 'Please try again'}')),
    );
  }


  @override
  void dispose() {
    _voucherController.dispose();
    _noteController.dispose();
    _paymentService.dispose();
    super.dispose();
  }

  double get _subtotal => _cartItems.fold(0, (sum, item) => sum + item.price * item.qty);
  double get _vat => _subtotal * _vatRate;
  double get _total => _subtotal + _deliveryFee + _platformFee + _vat;

  void _incrementQty(_CartLine item) => setState(() => item.qty++);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const Divider(height: 2,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._cartItems.map(_buildItemRow),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Row(
                          children: [
                            const Icon(Icons.add, size: 18, color: Colors.black87),
                            const SizedBox(width: 6),
                            Text('Add more items',
                                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,color: Color(0xFF000000))),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 2,),
                    _buildFeeBreakdown(),
                    const SizedBox(height: 26),
                    _buildVoucherField(),
                    const SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      color: _pageBackgroundPink,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDeliveryAddress(),
                          _buildPaymentMethod(),
                          _buildOrderSummary(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
            ),
      ),
    );
  }
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cart', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
              if (widget.restaurantName != null)
                Text(
                  widget.restaurantName!,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500,letterSpacing: 0.9,color: Color(0xFF5C5A5A)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(_CartLine item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 52,
              height: 52,
              child: Image.asset(item.imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                  'Rs. ${item.price.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                // onTap: () => _decrementOrRemove(item),
                onTap: item.qty >1 ? (){
                  setState(() {
                    item.qty--;
                  });
                } : null,
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(0)),
                  child: Icon(Icons.remove,
                    size: 15,color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(item.qty.toString(), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _incrementQty(item),
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(0)),
                  child: const Icon(Icons.add, size: 15, color: Colors.black87),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeBreakdown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _feeRow('Subtotal', _subtotal, bold: true),
          const SizedBox(height: 20),
          _feeRow('Standard delivery', _deliveryFee),
          const SizedBox(height: 20),
          _feeRow('Platform fee', _platformFee),
          const SizedBox(height: 20),
          _feeRow('VAT', _vat),
        ],
      ),
    );
  }

  Widget _feeRow(String label, double amount, {bool bold = false}) {
    final style = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      color: bold ? Colors.black : Colors.grey[700],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('Rs. ${amount.toStringAsFixed(2)}', style: style),
      ],
    );
  }

  Widget _buildVoucherField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: TextField(
          controller: _voucherController,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            prefixIcon: const Icon(Icons.confirmation_number_outlined, size: 20,color: Color(0xFF8D8686),),
            hintText: 'Apply a voucher',
            hintStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400,letterSpacing: 0.9, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery address', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF000000))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Ashok Nagar', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4,),
                          Text('New Delhi', style: GoogleFonts.inter(fontSize: 11.5,fontWeight: FontWeight.w300, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text( 'Change address',
                        style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w600,color: Color(0xFFDE4D17),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFDAD4D4)),
                  ),
                  child: TextField(
                    controller: _noteController,
                    style: GoogleFonts.inter(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Note to rider',
                      hintStyle: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.w300, color: Color(0xFF676363)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment method', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF000000))),
              GestureDetector(
                onTap: () => setState(() => _showPaymentOptions = !_showPaymentOptions),
                child: Text(
                  _showPaymentOptions ? 'Done' : 'Change',
                  style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w600,color: Color(0xFFDE4D17)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!_showPaymentOptions)
            _paymentRow(_selectedPayment, showAmount: true)
          else
            Column(
              children: _PaymentMethod.values.map((method) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _selectedPayment = method;
                      _showPaymentOptions = false;
                    }),
                    child: _paymentRow(method, showRadio: true),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _paymentRow(_PaymentMethod method, {bool showAmount = false, bool showRadio = false}) {
    final icons = {
      _PaymentMethod.cash: Icons.payments_outlined,
      _PaymentMethod.creditCard: Icons.credit_card,
      _PaymentMethod.upi: Icons.account_balance_wallet_outlined,
    };
    final labels = {
      _PaymentMethod.cash: 'Cash on delivery',
      _PaymentMethod.creditCard: 'Credit or Debit Card',
      _PaymentMethod.upi: 'UPI',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icons[method], size: 20, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Text(labels[method]!, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          if (showAmount)
            Text('Rs. ${_total.toStringAsFixed(1)}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
          if (showRadio)
            Icon(
              method == _selectedPayment ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: method == _selectedPayment ? AppColors.primary : Colors.grey,
            ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order summary',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF000000))),
          const SizedBox(height: 10),
          ..._cartItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.qty} x ${item.name}',
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xFF847F7F)),
                    ),
                    Text(
                      'Rs. ${_total.toStringAsFixed(1)}',
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8,),
          const Divider(height: 20),
          _feeRow('Subtotal', _subtotal),
          const SizedBox(height: 12),
          _feeRow('Standard delivery', _deliveryFee),
          const SizedBox(height: 12),
          _feeRow('Platform fee', _platformFee),
          const SizedBox(height: 12),
          _feeRow('VAT', _vat),
          const SizedBox(height: 14),
          const Divider(height: 10,),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 11,letterSpacing: 0.9, color: Color(0xFF4B4848)),
              children: [
                const TextSpan(text: 'By completing this order, I agree to all '),
                TextSpan(
                  text: 'terms & conditions.',
                  style: const TextStyle(decoration: TextDecoration.underline, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 12, offset: const Offset(0, -4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total (inc. fee and tax)',
                      style: GoogleFonts.inter(fontSize: 14,letterSpacing: 0.8, fontWeight: FontWeight.w700)),
                  Text('See summary', style: GoogleFonts.inter(fontSize: 11,fontWeight: FontWeight.w500, color: Color(0xFF3B3737))),
                ],
              ),
              Text('Rs. ${_total.toStringAsFixed(1)}',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12), 
          ElevatedButton(
            // onPressed: () {
            //   Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const OrderSuccessScreen()));
            // },
            onPressed: _isProcessingPayment ? null : _onPlaceOrderPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFE6D38),
              disabledBackgroundColor: Color(0xFFFE6D38),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: _isProcessingPayment ? const SizedBox(width: 22,height: 22,child: CircularProgressIndicator(color: Colors.white,),): 
            Text('Place order',
              style: GoogleFonts.inter(fontSize: 15, letterSpacing: 0.8,fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}