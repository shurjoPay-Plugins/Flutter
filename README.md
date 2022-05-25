![image](https://user-images.githubusercontent.com/57352037/170198396-932692aa-3354-4cf0-abc1-2b8ef43a6de3.png)
# ShurjoPay

Shurjopay flutter integration steps
## Prerequisite
To integrate ShurjoPay you need few credentials to access shurjopay:
```
:param prefix: Any string not more than 5 characters. It distinguishes the stores of a merchant.
:param currency: ISO format,(only BDT and USD are allowed).
:param return_url: Merchant should provide a GET Method return url to verify users initiated transaction status. 
:param cancel_url: Merchant should provide a cancel url to redirect the user if he/she cancels the transaction in midway. 
:param client_ip: User's ip
:param username: Merchant Username provided by shurjopay.
:param password: Merchant Password provided by shurjopay.
:param post_address: Live shurjopay version 2 URL.
```


> 📝 **NOTE** For shurjoPay version 2 live engine integration's all necessary credential will be given to merchant after subscription completed on shurjoPay gateway.



# flutter-shurjopay-sdk-example
Flutter shurjoPay SDK Example

[![pub package](https://img.shields.io/pub/v/shurjopay_sdk.svg)](https://pub.dartlang.org/packages/shurjopay_sdk)

### GIT Command
```git_command
git init
git remote add origin https://github.com/smukhidev/fluttre.git
git remote -v
git fetch && git checkout master
git add .
git commit -m "Add Readme & Git Commit File"
git pull
git push --all
git status
git status
```

# Usage

Flutter Environment: `flutter environment sdk and flutter version`

    sdk: ">=2.12.0 <3.0.0"
    flutter: ">=1.20.0"

Add dependencies: <kbd>shurjopay_sdk</kbd>

```git_request_dependencies
dependencies:
    connectivity_plus: ^2.1.0
    http: ^0.13.4
    webview_flutter: ^3.0.0
    shurjopay_sdk: ^latest_version
```

Import package:

```git_request_import
import "package:shurjopay_sdk/shurjopay_sdk.dart";
```

Android build.gradle

```git_build_gradle
defaultConfig {
    minSdkVersion 20
}
```

Android AndroidManifest.xml

```git_android_manifest_xml
<uses-permission android:name="android.permission.INTERNET"/>
```

### Request Data Model Setup:

```git_request_data_model_setup
// TODO request data model setup
RequiredRequestData requiredRequestData = RequiredRequestData(
    username:           "username",
    password:           "password",
    prefix:             "prefix",
    currency:           "currency",
    amount:             1,
    orderId:            "order_id",
    discountAmount:     0,
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
);
```

### Response Listener:

```git_response_listener_setup
// TODO response listener
onSuccess:          (BuildContext context, TransactionInfo transactionInfo)
onFailed:           (BuildContext context, String message)
onInternetFailed:   (BuildContext context, String message)
```

### Response Listener Setup:

```git_response_listener_setup
// TODO request response listener setup
ShurjopaySdk shurjopaySdk = ShurjopaySdk(
    onSuccess: (BuildContext context, TransactionInfo transactionInfo) {
        // TODO you get success response, if the transection is succefully completed.
    },
    onFailed: (BuildContext context, String message) {
        // TODO you get failed response, if the transection is failed or canceled.
    },
    onInternetFailed: (BuildContext context, String message) {
        // TODO you get internet failed message, if the internet is not connected or on internet.
    },
);
```

### Payment Request Setup:

```git_payment_request_setup
// TODO payment request setup
shurjopaySdk.makePayment(
    context:    context,
    sdkType:    "sdk request type live or sandbox", //TODO live/sandbox request
    data:       requiredRequestData,
);
```

### Payment Request Type:
```git_payment_request_type
// TODO payment request type
AppConstants.SDK_TYPE_SANDBOX
// TODO or
AppConstants.SDK_TYPE_LIVE
```

### Payment Success Respons:

```git_payment_respons_data
onSuccess: (BuildContext context, TransactionInfo transactionInfo) {
    // TODO you get success response, if the transection is succefully completed.
    int?    id                  = transactionInfo.id;
    String  orderId             = transactionInfo.orderId;
    String? currency            = transactionInfo.currency;
    double? amount              = transactionInfo.amount;
    double? payableAmount       = transactionInfo.payableAmount;
    double? discsountAmount     = transactionInfo.discsountAmount;
    double? discPercent         = transactionInfo.discPercent;
    double? usdAmt              = transactionInfo.usdAmt;
    double? usdRate             = transactionInfo.usdRate;
    String? cardHolderName      = transactionInfo.cardHolderName;
    String? cardNumber          = transactionInfo.cardNumber;
    String? phoneNo             = transactionInfo.phoneNo;
    String? bankTrxId           = transactionInfo.bankTrxId;
    String? invoiceNo           = transactionInfo.invoiceNo;
    String? bankStatus          = transactionInfo.bankStatus;
    String? customerOrderId     = transactionInfo.customerOrderId;
    int?    spCode              = transactionInfo.spCode;
    String? spMassage           = transactionInfo.spMassage;
    String? name                = transactionInfo.name;
    String? email               = transactionInfo.email;
    String? address             = transactionInfo.address;
    String? city                = transactionInfo.city;
    String? transactionStatus   = transactionInfo.transactionStatus;
    String? dateTime            = transactionInfo.dateTime;
    String? method              = transactionInfo.method;
    String? value1              = transactionInfo.value1;
    String? value2              = transactionInfo.value2;
    String? value3              = transactionInfo.value3;
    String? value4              = transactionInfo.value4;
}
```

### Payment Request Data Model (Data Type):

```git_payment_request_data_type
CheckoutRequestData
String  token;
int     storeId;
String  prefix;
String  currency;
String  returnUrl;
String  cancelUrl;
double  amount;
String  orderId;
double? discsountAmount;
double? discPercent;
String  clientIp;
String  customerName;
String  customerPhone;
String? customerEmail;
String  customerAddress;
String  customerCity;
String? customerState;
String? customerPostcode;
String? customerCountry;
String? value1;
String? value2;
String? value3;
String? value4;
```

### Payment Respons Data Model (Data Type):

```git_payment_response_data_type
TransactionInfo
int?    id;
String  orderId;
String? currency;
double? amount;
double? payableAmount;
double? discsountAmount;
double? discPercent;
double? usdAmt;
double? usdRate;
String? cardHolderName;
String? cardNumber;
String? phoneNo;
String? bankTrxId;
String? invoiceNo;
String? bankStatus;
String? customerOrderId;
int?    spCode;
String? spMassage;
String? name;
String? email;
String? address;
String? city;
String? transactionStatus;
String? dateTime;
String? method;
String? value1;
String? value2;
String? value3;
String? value4;
```


Flutter shurjoPay SDK v2

### Postman Documentations

    This document will illustrate the overall request and response flow.
    URL : https://documenter.getpostman.com/view/6335853/U16dS8ig	
		
### Who do I talk to? ###
	For any technical assistance please contact to: https://shurjopay.com.bd/#contacts


