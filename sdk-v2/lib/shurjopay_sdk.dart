import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:shurjopay_sdk/shurjopay_sdk.dart';
import "package:shurjopay_sdk/src/sdk/shurjopay_sdk_plugin.dart";
import "package:shurjopay_sdk/src/utils/pro_internet.dart";
import "package:shurjopay_sdk/src/utils/utility.dart";

/// Exported data and class
export "src/model/required_request_data.dart";
export "src/model/data_transaction_info.dart";
export "src/utils/app_constants.dart";
export "src/model/error_success.dart";
export "src/model/es_type.dart";

/// shurjoPay SDK Class
class ShurjopaySdk {
  /// shurjoPay onSuccess Listener
  ///
  /// shurjoPay onSuccess listener that accept BuildContext and TransactionInfo parameter.
  late final Function(BuildContext context, ErrorSuccess errorSuccess)
      onSuccess;

  /// shurjoPay onFailed Listener
  ///
  /// shurjoPay onFailed listener that accept BuildContext and String parameter.
  late final Function(BuildContext context, ErrorSuccess errorSuccess) onFailed;

  /// shurjoPay onInternetFailed Listener
  ///
  /// shurjoPay onInternetFailed listener that accept BuildContext and String parameter.
  late final Function(BuildContext context, String message) onInternetFailed;

  /// isShowDialog is use for check the progress dialog is open or not.
  bool _isShowDialog = false;

  static const MethodChannel _channel = MethodChannel('shurjopay_sdk');

  ShurjopaySdk({required this.onSuccess, required this.onFailed});

  /*ShurjopaySdk({
    required this.onSuccess,
    required this.onFailed,
    required this.onInternetFailed,
  });*/

  /// platformVersion code block
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod("getPlatformVersion");
    return version;
  }

  /// makePayment Method
  ///
  /// makePayment method with BuildContext, String and RequiredRequestData parameter.
  Future<void> makePayment({
    required BuildContext context,
    required String sdkType,
    required RequiredRequestData data,
  }) async {
    _isShowDialog = _showLoaderDialog(context);
    ErrorSuccess errorSuccess = ErrorSuccess(ESType.INTERNET_SUCCESS, null,
        "Internte connected ${Utility.lineNumber}");
    bool haveInternet = await ProInternet.isInternet();
    if (!haveInternet) {
      _onDismissDialog(context);
      errorSuccess = ErrorSuccess(ESType.INTERNET_ERROR, null,
          "Internte connection error. Please check your internte connection ${Utility.lineNumber}");
      onFailed(context, errorSuccess);
      return;
    }
    onSuccess(context, errorSuccess);
    //debugPrint("DEBUG_LOG_PRINT: ShurjopaySdk:makePayment");
    ShurjopaySdkPlugin sdkPlugin = ShurjopaySdkPlugin(
      onSuccess: (BuildContext context, ErrorSuccess errorSuccess) {
        //ErrorSuccess errorSuccess = ErrorSuccess("", ESType.SUCCESS);
        onSuccess(context, errorSuccess);
      },
      onFailed: (BuildContext context, ErrorSuccess errorSuccess) {
        onFailed(context, errorSuccess);
      },
      onDismissDialog: () {
        _onDismissDialog(context);
      },
    );
    if (sdkType.isEmpty) {
      errorSuccess = ErrorSuccess(ESType.ERROR, null, "${AppConstants.USER_INPUT_ERROR} ${Utility.lineNumber}");
      onFailed(context, errorSuccess);
      return;
    }
    if (data.amount <= 0) {
      errorSuccess = ErrorSuccess(ESType.ERROR, null, "${AppConstants.INVALID_AMOUNT} ${Utility.lineNumber}");
      onFailed(context, errorSuccess);
      return;
    }
    sdkPlugin.makePayment(context, sdkType, data);
  }

  /// _showLoaderDialog Method
  ///
  /// _showLoaderDialog method that accept BuildContext parameter and return boolean value.
  bool _showLoaderDialog(BuildContext context) {
    if (_isShowDialog) {
      return true;
    }
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

  /// _onDismissDialog Method
  ///
  /// _onDismissDialog method that accept BuildContext parameter.
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
