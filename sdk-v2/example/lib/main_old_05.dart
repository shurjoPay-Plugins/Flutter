import "dart:math";
import "package:flutter/material.dart";
import "package:shurjopay_sdk/shurjopay_sdk.dart";
import 'shurjopayuser01.dart';

/// main method for app entry point.
void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  /// shurjoPay SDK declaration.
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
            child: const Text("Pay By shurjoPay SDK"),
            onPressed: () {
              /// Call onShurjoPaySdk method with BuildContext.
              onShurjoPaySdk(context);
            },
          ),
        ),
      ),
    );
  }

  /// onShurjoPaySdk Method
  ///
  /// onShurjoPaySdk(BuildContext context) accept BuildContext parameter.
  void onShurjoPaySdk(BuildContext context) {
    /// shurjoPay SDK Request Data
    ///
    /// TODO request data model setup
    /// RequiredRequestData is user for shurjoPay payment request.
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "username",
      password: "password",
      prefix: "prefix",
      currency: "currency",
      amount: 1,
      orderId: "order_id",
      discountAmount: 0,
      discPercent: 0,
      customerName: "customer_name",
      customerPhone: "customer_phone",
      customerEmail: "customer_email",
      customerAddress: "customer_address",
      customerCity: "customer_city",
      customerState: "customer_state",
      customerPostcode: "customer_postcode",
      customerCountry: "customer_country",
      returnUrl: "return_url",
      cancelUrl: "cancel_url",
      clientIp: "client_ip",
      value1: "value1",
      value2: "value2",
      value3: "value3",
      value4: "value4",
    );
    //requiredRequestData = ShurjoPayUser().getSandboxUser();
    //debugPrint("DEBUG_LOG_PRINT: REQUEST_DATA: ${requiredRequestData}");
    requiredRequestData.onPrint();

    /// shurjoPay Response Listener
    ///
    /// TODO request response listener setup
    /// After request in shurjoPay SDK return and respons by this listener.
    shurjopaySdk = ShurjopaySdk(
      /// TODO you get success response, if the transection is succefully completed.
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        TransactionInfo? transactionInfo = errorSuccess.transactionInfo;
        debugPrint("DEBUG_LOG_PRINT: surjoPay SDK ${errorSuccess.esType.name}");
        switch (errorSuccess.esType) {
          case ESType.INTERNET_SUCCESS:
            debugPrint("DEBUG_LOG_PRINT: surjoPay SDK ${errorSuccess.message}");
            break;
          case ESType.INTERNET_ERROR:
            debugPrint("DEBUG_LOG_PRINT: surjoPay SDK ${errorSuccess.message}");
            break;
          case ESType.SUCCESS:
            debugPrint("DEBUG_LOG_PRINT: surjoPay SDK ${errorSuccess.message}");
            break;
          case ESType.ERROR:
            debugPrint("DEBUG_LOG_PRINT: surjoPay SDK ${errorSuccess.message}");
            break;
        }
        debugPrint("DEBUG_LOG_PRINT: surjoPay SDK payment successfull");
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK payment successfull ${transactionInfo!.id}");
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK payment successfull ${transactionInfo.value1}");
        debugPrint(
            "DEBUG_LOG_PRINT: surjoPay SDK payment successfull ${transactionInfo.value2}");
        int? id = transactionInfo.id;
        String orderId = transactionInfo.orderId;
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
        int? spCode = transactionInfo.spCode;
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

      /// TODO you get failed response, if the transection is failed or canceled.
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        debugPrint("DEBUG_LOG_PRINT: surjoPay SDK payment failed ${errorSuccess.message}");
      },
    );

    /// shurjoPay SDK Payment Request
    ///
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
}
