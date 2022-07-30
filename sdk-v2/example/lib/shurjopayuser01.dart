
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:shurjopay_sdk/shurjopay_sdk.dart';

class ShurjoPayUser {
  RequiredRequestData getSandboxUser() {
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
    return requiredRequestData;
  }
  RequiredRequestData getPaypointDigitalUser() {
    int orderId = Random().nextInt(1000);
    RequiredRequestData requiredRequestData = RequiredRequestData(
      username: "paypointDigital",
      password: "paypsy6q#jm#5jx5",
      prefix: "PPD",
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
    return requiredRequestData;
  }
  /*static void printObject(Object object, String message) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));
    // Using JsonEncoder for spacing
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);
    // print or debugPrint your object
    debugPrint("$message :user data: $prettyPrint");
  }*/
}