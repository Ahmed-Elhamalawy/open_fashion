import 'dart:convert';
import 'dart:developer' as developer;

/// Simple helper to print any list as pretty JSON
void printJson(List<dynamic> list) {
  const encoder = JsonEncoder.withIndent('  ');
  final jsonList = list.map((item) {
    if (item is Map) {
      return item;
    }
    // Check if item has toJson method
    try {
      return item.toJson();
    } catch (e) {
      return item.toString();
    }
  }).toList();

  final prettyJson = encoder.convert(jsonList);
  developer.log(prettyJson, name: 'JSON');
}
