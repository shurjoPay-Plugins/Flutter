import "dart:async";
import "dart:convert";
//import "dart:html";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:shurjopay_sdk/shurjopay_sdk.dart";
import "package:shurjopay_sdk/src/model/data_response_checkout.dart";
import "package:shurjopay_sdk/src/model/data_token.dart";
import "package:shurjopay_sdk/src/sdk/api_client.dart";
import "package:shurjopay_sdk/src/sdk/web_view_container.dart";
import 'package:shurjopay_sdk/src/utils/utility.dart';

/// Shurjopay SDK Plugin Class
class ShurjopaySdkPlugin {
  late BuildContext _context;
  /// shurjoPay onSuccess Listener
  ///
  /// shurjoPay onSuccess listener that accept BuildContext and TransactionInfo parameter.
  late final Function(BuildContext context, ErrorSuccess errorSuccess) onSuccess;
  /// shurjoPay onFailed Listener
  ///
  /// shurjoPay onFailed listener that accept BuildContext and String parameter.
  late final Function(BuildContext context, ErrorSuccess errorSuccesse) onFailed;
  /// shurjoPay onDismissDialog Listener
  ///
  /// shurjoPay onDismissDialog listener.
  late final Function() onDismissDialog;
  late String               _sdkType;
  late RequiredRequestData  _data;

  ShurjopaySdkPlugin({
    required this.onSuccess,
    required this.onFailed,
    required this.onDismissDialog,
  });

  void makePayment(
        BuildContext context,
        String sdkType,
        RequiredRequestData data
      ) {
    //debugPrint("DEBUG_LOG_PRINT: ${Utility.lineNumber}");
    this._context = context;
    _sdkType  = sdkType;
    _data     = data;
    _getToken(context);
  }

  Future<void> _getToken(BuildContext context) async {
    Token token = Token(
      username:   _data.username,
      password:   _data.password,
      token:      null,
      storeId:    null,
      executeUrl: null,
      tokenType:  null,
      spCode:     null,
      massage:    null,
      expiresIn:  null,
    );
    //
    var url = Uri.parse(ApiClient.getApiClient(_sdkType).getToken());
    //url = Uri.parse("https://httpbin.org/post");
    //url = Uri.parse("http://192.168.10.61/plugins.php");
    //debugPrint("DEBUG_LOG_PRINT_URL:_getToken: ${url.toString()} ${Utility.lineNumber}");
    try {
      final response = await http.post(url, body: {
        "username": _data.username,
        "password": _data.password,
      }, headers: {
        //"Accept":   "application/json"
      });
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "");
      if (response.statusCode != 200) {
        onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null, "Error post data, status code: ${response.statusCode} ${response.body} ${Utility.lineNumber}");
        onFailed(context, errorSuccess);
        return;
      }
      //debugPrint("DEBUG_LOG_PRINT_URL: ${response.body} ${Utility.lineNumber}");
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse["sp_code"].toString() != "200") {
        onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null, "Error unauthorized, status code: ${response.statusCode} output message: ${jsonResponse["message"]} ${Utility.lineNumber}");
        onFailed(context, errorSuccess);
        return;
      }
      token = Token.fromJson(jsonDecode(response.body));
      //debugPrint("DEBUG_LOG_PRINT_URL: ${token.spCode} ${Utility.lineNumber}");
      _getExecuteUrl(context, token);
    } catch (e) {
      onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.ERROR, null, "${e.toString()} ${Utility.lineNumber}");
      onFailed(context, errorSuccess);
    }
  }

  Future<void> _getExecuteUrl(BuildContext context, Token token) async {
    var url = Uri.parse(ApiClient.getApiClient(_sdkType).checkout());
    //debugPrint("DEBUG_LOG_PRINT_URL: ${url.toString()} ${Utility.lineNumber}");
    try {
      final response = await http.post(url, body: {
        "token":              "${token.token}",
        "store_id":           "${token.storeId}",
        "prefix":             _data.prefix,
        "currency":           _data.currency,
        "amount":             "${_data.amount}",
        "order_id":           _data.orderId,
        "discsount_amount":   "${_data.discountAmount}",
        "disc_percent":       "${_data.discPercent}",
        "client_ip":          "${_data.clientIp}",
        "customer_name":      _data.customerName,
        "customer_phone":     _data.customerPhone,
        "customer_email":     "${_data.customerEmail}",
        "customer_address":   _data.customerAddress,
        "customer_city":      "${_data.customerCity}",
        "customer_state":     "${_data.customerState}",
        "customer_postcode":  "${_data.customerPostcode}",
        "customer_country":   "${_data.customerCountry}",
        "return_url":         "${_data.returnUrl}",
        "cancel_url":         "${_data.cancelUrl}",
        "value1":             "${_data.value1}",
        "value2":             "${_data.value2}",
        "value3":             "${_data.value3}",
        "value4":             "${_data.value4}",
      }, headers: {
        "Accept":             "application/json",
        "Authorization": "${token.tokenType} ${token.token}",
      });
      onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.SUCCESS, null, "");
      if (response.statusCode != 200) {
        //onDismissDialog();
        errorSuccess = ErrorSuccess(ESType.ERROR, null, "Error post data, status code: ${response.statusCode} ${response.body} ${Utility.lineNumber}");
        onFailed(context, errorSuccess);
        return;
      }
      //onDismissDialog();
      //debugPrint("DEBUG_LOG_PRINT_URL: ${response.body} ${Utility.lineNumber}");
      CheckoutResponseData checkoutResponseData =
          CheckoutResponseData.fromJson(jsonDecode(response.body));
      //debugPrint("DEBUG_LOG_PRINT_URL: ${checkoutResponseData.checkoutUrl} ${Utility.lineNumber}");
      _showWebView(context, token, checkoutResponseData);
    } catch (e) {
      onDismissDialog();
      ErrorSuccess errorSuccess = ErrorSuccess(ESType.ERROR, null, "${e.toString()} ${Utility.lineNumber}");
      onFailed(context, errorSuccess);
    }
  }

  void _showWebView(BuildContext context, Token argToken,
      CheckoutResponseData argCheckoutResponseData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebViewContainer(
        requestData:      _data,
        apiUrl:           argCheckoutResponseData.checkoutUrl,
        sdkType:          _sdkType,
        checkoutModel:    argCheckoutResponseData,
        tokenModel:       argToken,
        onSuccess:        (BuildContext context, ErrorSuccess errorSuccess) {
          //ErrorSuccess errorSuccess = ErrorSuccess("", ESType.SUCCESS);
          onSuccess(context, errorSuccess);
        },
        onFailed:         (BuildContext context, ErrorSuccess errorSuccess) {
          onFailed(context, errorSuccess);
        },
        onDismissDialog:  () {
          onDismissDialog();
        },
      ),
      settings: const RouteSettings(name: "shurjoPayView"),
    ));
  }
}
