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
  /// shurjoPay SDK declaration.
  late ShurjopaySdk shurjopaySdk;
  
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
    /// TODO request data model setup
    /// RequiredRequestData is user for shurjoPay payment request.
    RequiredRequestData requiredRequestData = requestData;
    requiredRequestData.onPrint();
    /// shurjoPay Response Listener
    ///
    /// TODO request response listener setup
    /// After request in shurjoPay SDK return and respons by this listener.
    shurjopaySdk = ShurjopaySdk(
      /// TODO you get success response, if the transection is succefully completed.
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        switch (errorSuccess.esType) {
          case ESType.INTERNET_SUCCESS:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.message}");
            return;
          case ESType.SUCCESS:
            //debugPrint("DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.message}");
            onTransaction(errorSuccess.transactionInfo);
            return;
        }
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK SUCCESS: ${errorSuccess.esType.name}");
      },

      /// TODO you get failed response, if the transection is failed or canceled.
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        switch (errorSuccess.esType) {
          case ESType.INTERNET_ERROR:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            return;
          case ESType.HTTP_CANCEL:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            return;
          case ESType.ERROR:
            debugPrint(
                "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
            return;
        }
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK ERROR: ${errorSuccess.message}");
      },
    );
    /// TODO payment request setup
    /// shurjoPay payment request by makePayment method.
    /// It takes context, sdkType and request data.
    shurjopaySdk.makePayment(
      context: context,

      /// TODO live/sandbox request
      sdkType: AppConstants.SDK_TYPE_SANDBOX,
      data: requiredRequestData,
    );
  }

  void onTransaction(TransactionInfo? transactionInfo) {
    debugPrint("DEBUG_LOG_PRINT: surjoPay SDK SUCCESS TransactionInfo:");
    transactionInfo?.onPrint();
  }

  RequiredRequestData get requestData {
    int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "sp_sandbox",
      password: "pyyk97hu&6u6",
      prefix: "NOK",
      currency: "BDT",
      amount: 1,
      orderId: "NOK$orderId",
      discountAmount: 0,
      discPercent: 0,
      customerName: "customer name",
      customerPhone: "01711486915",
      customerEmail: null,
      customerAddress: "customer address",
      customerCity: "customer city",
      customerState: null,
      customerPostcode: null,
      customerCountry: null,
      returnUrl: "https://www.sandbox.shurjopayment.com/response",
      cancelUrl: "https://www.sandbox.shurjopayment.com/response",
      clientIp: "127.0.0.1",
      value1: null,
      value2: null,
      value3: null,
      value4: null,
    );
    //requiredRequestData = ShurjoPayUser().getSandboxUser();
    //debugPrint("DEBUG_LOG_PRINT: REQUEST_DATA: ${requiredRequestData}");
    return requiredRequestData;
  }
}
