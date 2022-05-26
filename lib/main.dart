import 'dart:math';

import "package:flutter/material.dart";
import "package:shurjopay_sdk/shurjopay_sdk.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo shurjoPaySDK",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Flutter Demo shurjoPaySDK"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Pay By shurjoPay SDK"),
          onPressed: () {
            onShurjopaySdk(context);
          },
        ),
      ),
    );
  }
  void onShurjopaySdk(BuildContext context) {
    // TODO request data model setup
    int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "username",
      password: "password",
      prefix: "prefix",
      currency: "BDT",
      amount: 1,
      orderId: "prefix$orderId",
      discountAmount: 0,
      discPercent: 0,
      customerName: "customer name",
      customerPhone: "customerPhone",
      customerEmail: null,
      customerAddress: "customer address",
      customerCity: "customer city",
      customerState: null,
      customerPostcode: null,
      customerCountry: null,
      returnUrl: "https://www.sandbox.shurjopayment.com/return_url",
      cancelUrl: "https://www.sandbox.shurjopayment.com/cancel_url",
      clientIp: "127.0.0.1",
      value1: null,
      value2: null,
      value3: null,
      value4: null,
    );
    // TODO request response listener setup
    ShurjopaySdk shurjopaySdk = ShurjopaySdk(
      onSuccess: (BuildContext context, TransactionInfo transactionInfo) {
        // TODO you get success response, if the transection is succefully completed.
        print("DEBUG_LOG_PRINT: onSuccess");
      },
      onFailed: (BuildContext context, String message) {
        // TODO you get failed response, if the transection is failed or canceled.
        print("DEBUG_LOG_PRINT:onFailed: $message");
      },
      onInternetFailed: (BuildContext context, String message) {
        // TODO you get internet failed message, if the internet is not connected or on internet.
        print("DEBUG_LOG_PRINT:onInternetFailed: $message");
      },
    );
    // TODO payment request setup
    shurjopaySdk.makePayment(
      context:    context,
      sdkType:    AppConstants.SDK_TYPE_SANDBOX, //TODO live/sandbox request
      data:       requiredRequestData,
    );
  }
}
