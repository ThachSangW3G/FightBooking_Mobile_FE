import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flightbooking_mobile_fe/services/payment_service.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentService paymentService =
      PaymentService(baseUrl: 'http://192.168.1.10:7050/payment');
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod? selectedPaymentMethod;
  bool isLoading = false;
  bool showNewCardForm = false;
  String? message;
  String? customerId;
  String? setupIntentId;
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0aHVvbmdzcCIsImlhdCI6MTcxOTU4NTE0OCwiZXhwIjoxNzE5NTk5NTQ4fQ.tV056QJmk0xOeT2X4vz-FtkJEsxDJBxtn3OOxf7-vs4';
  String email = 'ledangthuongsp@gmail.com';

  double amount = 5;

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        "pk_test_51OVwerA7WrEjctnX9STvulzywtvSiHbBfwpWtPz1qUisHRlxGoqeYEsezmX3wub802xxdEyo6N65w2zLu77HLP3200k4IHYlWU";
    initializePaymentFlow();
  }

  Future<void> initializePaymentFlow() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Step 1: Get or create customer ID
      customerId = await paymentService.getCustomerId(token);
      setupIntentId = await paymentService.createSetupIntent(customerId!);
      if (customerId == null || setupIntentId == null) {
        customerId = await paymentService.createCustomer(email);
        await paymentService.createSetupIntent(customerId!);
      }

      // Step 2: Fetch payment methods
      paymentMethods =
          (await paymentService.getPaymentMethods(email)).cast<PaymentMethod>();
    } catch (error) {
      setState(() {
        message = 'Error initializing payment flow: $error';
      });
      print('Error: $error'); // Log the error for debugging
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> handlePayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (showNewCardForm) {
        await handleNewCardPayment();
      } else {
        await handleExistingCardPayment();
      }
    } catch (error) {
      setState(() {
        message = 'Error occurred during payment process: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> handleNewCardPayment() async {
    if (customerId == null) {
      throw 'Customer ID not found';
    }

    // Step 1: Create setup intent
    final clientSecret = await paymentService.createSetupIntent(customerId!);

    // Step 2: Confirm card setup
    final paymentMethodParams = PaymentMethodParams.card(
        paymentMethodData:
            PaymentMethodData(billingDetails: BillingDetails(email: email)));
    final setupIntentResult = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: clientSecret, params: paymentMethodParams);

    if (setupIntentResult.status == PaymentIntentsStatus.Succeeded) {
      final paymentMethodId = setupIntentResult.paymentMethodId;

      // Step 3: Attach payment method
      await paymentService.attachPaymentMethod(customerId!, paymentMethodId!);

      setState(() {
        showNewCardForm = false;
        message = 'Card added successfully!';
      });

      // Step 4: Refresh payment methods
      paymentMethods =
          (await paymentService.getPaymentMethods(email)).cast<PaymentMethod>();
    } else {
      throw 'Failed to set up the card';
    }
  }

  Future<void> handleExistingCardPayment() async {
    if (selectedPaymentMethod == null) {
      throw 'Payment method not selected';
    }

    final clientSecret = await paymentService.createPayment(token, amount);
    final paymentConfirmResult = await Stripe.instance
        .confirmPayment(paymentIntentClientSecret: clientSecret);

    if (paymentConfirmResult.status == PaymentIntentsStatus.Succeeded) {
      setState(() {
        message = 'Payment successful!';
      });
    } else {
      throw 'Payment failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (showNewCardForm)
                    Column(
                      children: [
                        CardField(),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: handlePayment, child: Text('Add Card')),
                      ],
                    )
                  else
                    Column(
                      children: [
                        DropdownButton<PaymentMethod>(
                          hint: Text('Select a card'),
                          value: selectedPaymentMethod,
                          onChanged: (PaymentMethod? newValue) {
                            setState(() {
                              selectedPaymentMethod = newValue;
                            });
                          },
                          items: paymentMethods
                              .map<DropdownMenuItem<PaymentMethod>>(
                                  (PaymentMethod method) {
                            return DropdownMenuItem<PaymentMethod>(
                              value: method,
                              child: Text(
                                  '${method.card.brand} **** ${method.card.last4}'),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: handlePayment, child: Text('Pay')),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showNewCardForm = !showNewCardForm;
                      });
                    },
                    child: Text(showNewCardForm ? 'Cancel' : 'Add New Card'),
                  ),
                  if (message != null) ...[
                    SizedBox(height: 20),
                    Text(message!, style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
    );
  }
}
