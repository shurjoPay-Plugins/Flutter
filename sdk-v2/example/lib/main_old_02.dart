import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shurjopay_sdk/shurjopay_sdk.dart';

/*void main() {
  runApp(MyApp());
}*/

/*class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  late RequiredRequestData requiredRequestData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('First Screen'),
      ),*/
      body: Center(
        child: ElevatedButton(
          child: const Text('Launch screen'),
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );*/
            onRequestSandbox(context);
          },
        ),
      ),
    );
  }

  void onRequestSandbox(BuildContext context) {
    //int orderId = Random().nextInt(1000000);
    int orderId = Random().nextInt(1000);
    requiredRequestData = RequiredRequestData(
      username: "sp_sandbox",
      password: "pyyk97hu&6u6",
      prefix: "NOK",
      currency: "BDT",
      amount: 5,
      orderId: "PPD$orderId",
      discountAmount: 0,
      discPercent: 0,
      customerName: "customer name",
      customerPhone: "01xxxxxxxxx",
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
    //ShurjopaySdk shurjopaySdk = ShurjopaySdk();
    /*shurjopaySdk.setRequiredRequestData(
            );*/
    ShurjopaySdk shurjopaySdk = ShurjopaySdk(
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        print("DEBUG_LOG_PRINT:onSuccess: success");
      },
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        print("DEBUG_LOG_PRINT:onFailed: ${errorSuccess.message}");
      }
    );
    shurjopaySdk.makePayment(
      context: context,
      sdkType: AppConstants.SDK_TYPE_SANDBOX,
      data: requiredRequestData,
    );
    //ShurjopaySdk.haveInternet(context);
  }

  /*void onRequestLive(BuildContext context) {
    int orderId = Random().nextInt(1000000);
    requiredRequestData = RequiredRequestData(
      username: "paypointDigital",
      password: "paypsy6q#jm#5jx5",
      prefix: "PPD",
      currency: "BDT",
      amount: 5.0,
      orderId: "PPD $orderId",
      discountAmount: null,
      discPercent: null,
      customerName: "customer name",
      customerPhone: "01812166111",
      customerEmail: null,
      customerAddress: "customer address",
      customerCity: "customer city",
      customerState: null,
      customerPostcode: null,
      customerCountry: null,
      value1: null,
      value2: null,
      value3: null,
      value4: null,
    );
    ShurjopaySdk shurjopaySdk = ShurjopaySdk(
      onSuccess: (BuildContext context, TransactionInfo transactionInfo) {
        //print("DEBUG_LOG_PRINT:onSuccess: success");
        _showToast(context, "Success: ${transactionInfo.spMassage}");
      },
      onFailed: (BuildContext context, String message) {
        print("DEBUG_LOG_PRINT:onFailed: $message");
        _showToast(context, "Error: $message");
      },
      onInternetFailed: (BuildContext context, String message) {
        print("DEBUG_LOG_PRINT:onInternetFailed: $message");
        _showToast(context, "Error: $message");
      },
    );
    shurjopaySdk.makePayment(
      context: context,
      sdkType: AppConstants.SDK_TYPE_LIVE,
      data: requiredRequestData,
    );
  }*/

  void _showToast(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(message)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
/*class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child:
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            },
                            child: Text(' Print Console Message using Print '),
                            textColor: Colors.white,
                            color: Colors.green,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          )
                      ),

                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child:
                          RaisedButton(
                            onPressed: () => showConsoleUsingDebugPrint(),
                            child: Text(' Print Console Message using Debug Print '),
                            textColor: Colors.white,
                            color: Colors.green,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          )
                      ),

                    ])
            )
        )
    );
  }
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
  void showConsoleUsingPrint() {
    print('Console Message Using Print');
  }
  void showConsoleUsingDebugPrint() {
    debugPrint('Console Message Using Debug Print');
  }
}*/
/*
4444 4444 4444 4444
01 2030 123
shurjopay
*/
