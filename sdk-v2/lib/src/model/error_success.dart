import '../../shurjopay_sdk.dart';

class ErrorSuccess {
  late TransactionInfo? transactionInfo;
  ESType esType = ESType.NONE;
  String message = "";

  ErrorSuccess(ESType esType, TransactionInfo? transactionInfo, String message) {
    this.esType   = esType;
    this.transactionInfo = transactionInfo;
    this.message  = message;
  }
}
