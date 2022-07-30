import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";
import "package:shurjopay_sdk/shurjopay_sdk.dart";
import "package:shurjopay_sdk/src/model/data_response_checkout.dart";
import "package:shurjopay_sdk/src/model/data_token.dart";
import "package:shurjopay_sdk/src/sdk/api_client.dart";

import '../utils/utility.dart';

/// Web View Container Class
class WebViewContainer extends StatefulWidget {
  final Function(BuildContext context, ErrorSuccess errorSuccess) onSuccess;
  final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;
  final Function() onDismissDialog;
  final RequiredRequestData requestData;
  final String apiUrl;
  final String sdkType;
  final Token tokenModel;
  final CheckoutResponseData checkoutModel;

  const WebViewContainer({
    required this.requestData,
    required this.apiUrl,
    required this.sdkType,
    required this.checkoutModel,
    required this.tokenModel,
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  @override
  WebViewContainerState createState() => WebViewContainerState(
        requestData: requestData,
        apiUrl: apiUrl,
        sdkType: sdkType,
        tokenModel: tokenModel,
        checkoutModel: checkoutModel,
        onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
          //ErrorSuccess errorSuccess = ErrorSuccess("", ESType.SUCCESS);
          onSuccess(context, errorSuccess);
        },
        onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
          onFailed(context, errorSuccess);
        },
        onDismissDialog: () {
          onDismissDialog();
        },
      );
}

/// Web View Container State Class
class WebViewContainerState extends State<WebViewContainer> {
  final Function(BuildContext context, ErrorSuccess errorSuccess) onSuccess;
  final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;
  final Function() onDismissDialog;
  final RequiredRequestData requestData;
  final String apiUrl;
  final String sdkType;
  final Token tokenModel;
  final CheckoutResponseData checkoutModel;
  late WebViewController webViewController;
  bool _isShowDialog = false;

  WebViewContainerState({
    required this.requestData,
    required this.apiUrl,
    required this.sdkType,
    required this.checkoutModel,
    required this.tokenModel,
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          String? url = await webViewController.currentUrl();
          //debugPrint("DEBUG_LOG_PRINT:onWillPop: ${url} ${Utility.lineNumber}");
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: WebView(
              initialUrl: apiUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController argWebViewController) {
                webViewController = argWebViewController;
              },
              onPageFinished: (String url) {},
              onPageStarted: (String url) {
                //debugPrint("DEBUG_LOG_PRINT:onPageStarted: ${url}");
                if (url.contains(requestData.returnUrl.toString()) || url.contains(requestData.cancelUrl.toString())) {
                  _verifyPayment(context, sdkType);
                }
                return;
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyPayment(BuildContext context, String sdkType) async {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == "shurjoPayView");
    _isShowDialog = _showLoaderDialog(context);
    ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "");
    var url = Uri.parse(ApiClient.getApiClient(sdkType).verify());
    //debugPrint("DEBUG_LOG_PRINT:_verifyPayment: ${url.toString()} ${Utility.lineNumber}");
    try {
      final response = await http.post(url, body: {
        "order_id": checkoutModel.spOrderId,
      }, headers: {
        "Accept": "application/json",
        "Authorization": "${tokenModel.tokenType} ${tokenModel.token}",
      });
      Navigator.of(context)
          .popUntil((route) => route.settings.name == "shurjoPayView");
      _onDismissDialog(context);
      if (response.statusCode != 200) {
        setState(() {
          errorSuccess = ErrorSuccess(ESType.ERROR, null,
              "${AppConstants.PLEASE_CHECK_YOUR_PAYMENT}: ${response.statusCode} ${response.body}  ${Utility.lineNumber}");
          onFailed(context, errorSuccess);
        });
        return;
      }
      //debugPrint("DEBUG_LOG_PRINT_URL:_verifyPayment: ${response.body} ${Utility.lineNumber}");
      //List<dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> userData = List<dynamic>.from(json.decode(response.body));
      //debugPrint("DEBUG_LOG_PRINT_URL:_verifyPayment: ${userData.toString()} ${Utility.lineNumber}");
      //Map<String, dynamic> myMap = Map<String, dynamic>.from(json.decode(response.body));
      //TransactionInfo transactionInfo = TransactionInfo.getTransactionInfo(userData[userData.length - 1]);
      TransactionInfo transactionInfo =
          TransactionInfo.fromJson(userData[userData.length - 1]);
      //debugPrint("DEBUG_LOG_PRINT_URL:_verifyPayment: ${transactionInfo.toString()} ${Utility.lineNumber}");
      if (transactionInfo.spCode == 1000) {
        setState(() {
          errorSuccess = ErrorSuccess(ESType.SUCCESS, transactionInfo,
              "Payment successfull ${Utility.lineNumber}");
          onSuccess(context, errorSuccess);
        });
      } else {
        setState(() {
          errorSuccess = ErrorSuccess(ESType.ERROR, transactionInfo,
              "Error ${transactionInfo.spMassage} ${Utility.lineNumber}");
          onFailed(context, errorSuccess);
        });
      }
    } catch (e) {
      onDismissDialog();
      setState(() {
        errorSuccess = ErrorSuccess(
            ESType.ERROR, null, "${e.toString()} ${Utility.lineNumber}");
        onFailed(context, errorSuccess);
      });
    }
  }

  bool _showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
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
    return true;
  }

  void _onDismissDialog(BuildContext context) {
    if (_isShowDialog) {
      Navigator.pop(context, true);
      _isShowDialog = false;
    }
    while (_isShowDialog) {
      _onDismissDialog(context);
    }
  }
}
