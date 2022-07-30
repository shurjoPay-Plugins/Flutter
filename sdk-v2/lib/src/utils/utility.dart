import 'package:flutter/cupertino.dart';

class Utility {
  static String getString(dynamic value) {
    if (value is int) {
      return value.toString();
    } else {
      return value;
    }
  }

  static int getInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else {
      return value;
    }
  }

  static double getDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }
  static String get lineNumber {
    int level = 1;
    //var stackTrace = StackTrace.current.toString();
    var stackTrace = StackTrace.current;
    //debugPrint("DEBUG_LOG_PRINT: LINE_NUMBER: ${stackTrace.toString()}");
    var stackArray = stackTrace.toString().split("\n");
    if(stackArray.length < level) {
      return "Code: -1";
    }
    var stackTraceLine = stackArray[level];
    var stackLines = stackTraceLine.toString().split(" ");
    String stackTraceConcate = "";
    for (var i = 0; i < stackLines.length; i++) {
      if(stackLines[i] != "") {
        stackTraceConcate = stackTraceConcate + " " + stackLines[i];
      }
    }
    stackTraceConcate = stackTraceConcate.trim();
    //
    stackLines = stackTraceLine.toString().split(" ");
    stackTraceConcate = "";
    for (var i = 0; i < stackLines.length; i++) {
      if(i > 0) {
        stackTraceConcate = stackTraceConcate + " " + stackLines[i];
      }
    }
    stackTraceConcate = stackTraceConcate.trim().replaceAll(new RegExp(r"\(.*([a-z]|[A-Z]):"), "(");
    return "Code: ${stackTraceConcate.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}";
    //debugPrint("DEBUG_LOG_PRINT: LINE_NUMBER: $stackTraceConcate");
    /*try {
      final re = RegExp(r'^#1[ \t]+.+:(?[0-9]+):[0-9]+\)$', multiLine: true);
      final match = re.firstMatch(StackTrace.current.toString());
      return (match == null) ? -1 : int.parse(match.namedGroup("line").toString());
    } catch (e) {
      return 0;
    }*/
    //return "Code: 0";
  }
  int get lineNumberOld {
    try {
      final re =
      RegExp(r'^#1[ \t]+.+:(?[0-9]+):[0-9]+\)$', multiLine: true);
      final match = re.firstMatch(StackTrace.current.toString());
      return (match == null) ? -1 : int.parse(match.namedGroup("line").toString());
    } catch (e) {
      return 0;
    }
  }
}
