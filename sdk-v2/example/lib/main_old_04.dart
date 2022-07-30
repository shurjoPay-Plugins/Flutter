import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shurjopay_sdk/shurjopay_sdk.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ShurjopaySdk shurjopaySdk;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("shurjoPay SDK - shurjoMukhi Ltd"),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Launch screen'),
            onPressed: () {
              onShurjoPaySdk(context);
            },
          ),
        ),
      ),
    );
  }

  void onShurjoPaySdk(BuildContext context) {
    // TODO request data model setup
    /*RequiredRequestData requiredRequestData = RequiredRequestData(
      username:           "username",
      password:           "password",
      prefix:             "prefix",
      currency:           "currency",
      amount:             1,
      orderId:            "order_id",
      discountAmount:     "discount_amount",
      discPercent:        0,
      customerName:       "customer_name",
      customerPhone:      "customer_phone",
      customerEmail:      "customer_email",
      customerAddress:    "customer_address",
      customerCity:       "customer_city",
      customerState:      "customer_state",
      customerPostcode:   "customer_postcode",
      customerCountry:    "customer_country",
      returnUrl:          "return_url",
      cancelUrl:          "cancel_url",
      clientIp:           "client_ip",
      value1:             "value1",
      value2:             "value2",
      value3:             "value3",
      value4:             "value4",
    );*/
    /*int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "sp_sandbox",
      password: "pyyk97hu&6u6",
      prefix: "NOK",
      currency: "BDT",
      amount: 1,
      orderId: "PPD$orderId",
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
      returnUrl: "https://www.sandbox.shurjopayment.com/return_url",
      cancelUrl: "https://www.sandbox.shurjopayment.com/cancel_url",
      clientIp: "127.0.0.1",
      value1: null,
      value2: null,
      value3: null,
      value4: null,
    );*/
    int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username:           "sp_sandbox",
      password:           "pyyk97hu&6u6",
      prefix:             "NOK",
      currency:           "BDT",
      amount:             1,
      orderId:            "PPD$orderId",
      discountAmount:     0,
      discPercent:        0,
      customerName:       "customer_name",
      customerPhone:      "01711486915",
      customerEmail:      "customer_email",
      customerAddress:    "customer_address",
      customerCity:       "customer_city",
      customerState:      "customer_state",
      customerPostcode:   "customer_postcode",
      customerCountry:    "customer_country",
      returnUrl:          "https://www.sandbox.shurjopayment.com/return_url",
      cancelUrl:          "https://www.sandbox.shurjopayment.com/cancel_url",
      clientIp:           "127.0.0.1",
      value1:             "value1",
      value2:             "value2",
      value3:             "value3",
      value4:             "value4",
    );
    // TODO request response listener setup
    shurjopaySdk = ShurjopaySdk(
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        TransactionInfo? transactionInfo = errorSuccess.transactionInfo;
        // TODO you get success response, if the transection is succefully completed.
        int?    id = transactionInfo!.id;
        String  orderId = transactionInfo.orderId;
        String? currency = transactionInfo.currency;
        double? amount = transactionInfo.amount;
        double? payableAmount = transactionInfo.payableAmount;
        double? discsountAmount = transactionInfo.discsountAmount;
        double? discPercent = transactionInfo.discPercent;
        double? usdAmt = transactionInfo.usdAmt;
        double? usdRate = transactionInfo.usdRate;
        String? cardHolderName = transactionInfo.cardHolderName;
        String? cardNumber = transactionInfo.cardNumber;
        String? phoneNo = transactionInfo.phoneNo;
        String? bankTrxId = transactionInfo.bankTrxId;
        String? invoiceNo = transactionInfo.invoiceNo;
        String? bankStatus = transactionInfo.bankStatus;
        String? customerOrderId = transactionInfo.customerOrderId;
        int?    spCode = transactionInfo.spCode;
        String? spMassage = transactionInfo.spMassage;
        String? name = transactionInfo.name;
        String? email = transactionInfo.email;
        String? address = transactionInfo.address;
        String? city = transactionInfo.city;
        String? transactionStatus = transactionInfo.transactionStatus;
        String? dateTime = transactionInfo.dateTime;
        String? method = transactionInfo.method;
        String? value1 = transactionInfo.value1;
        String? value2 = transactionInfo.value2;
        String? value3 = transactionInfo.value3;
        String? value4 = transactionInfo.value4;
      },
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        // TODO you get failed response, if the transection is failed or canceled.
        print("==================> ${errorSuccess.message}");
      }
      /*,
      onInternetFailed: (BuildContext context, String message) {
        // TODO you get internet failed message, if the internet is not connected or on internet.
      },*/
    );
    // TODO payment request setup
    shurjopaySdk.makePayment(
      context:    context,
      sdkType:    AppConstants.SDK_TYPE_SANDBOX, //TODO live/sandbox request
      data:       requiredRequestData,
    );
  }
  countDownTimer(BuildContext context, int timerTime) async {
    int timerCount = timerTime;
    for (int x = timerCount; x > 0; x--) {
      await Future.delayed(Duration(seconds: 1)).then((_) {
        setState(() {
          timerCount -= 1;
          //print("TIME_COUNT: ${timerCount} ${shurjopaySdk.isShowDialog}");
        });
      });
    }
  }
}
/*
int orderId = Random().nextInt(1000);
RequiredRequestData requiredRequestData = RequiredRequestData(
  username: "sp_sandbox",
  password: "pyyk97hu&6u6",
  prefix: "NOK",
  currency: "BDT",
  amount: 1,
  orderId: "PPD$orderId",
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
  returnUrl: "https://www.sandbox.shurjopayment.com/return_url",
  cancelUrl: "https://www.sandbox.shurjopayment.com/cancel_url",
  clientIp: "127.0.0.1",
  value1: "user value1",
  value2: "user value2",
  value3: "user value3",
  value4: "user value4",
);
shurjopaySdk.makePayment(
  context: context,
  sdkType: AppConstants.SDK_TYPE_SANDBOX,
  data: requiredRequestData,
);
*/
