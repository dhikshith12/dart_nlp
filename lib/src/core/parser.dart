import 'package:nlp/nlp.dart';

abstract interface class IMergedParserConfiguration implements ICommonDateTimeParserConfiguration {
  RegExp getBeforeRegex();

  RegExp getAfterRegex();

  RegExp getSinceRegex();

  RegExp getAroundRegex();

  RegExp getSuffixAfterRegex();

  RegExp getYearRegex();

  RegExp getEqualRegex();

  bool checkBothBeforeAfter();

  // IDateTimeParser getGetParser();
  //
  // IDateTimeParser getHolidayParser();

  // IDateTimeParser getTimeZoneParser();

  // TODO: bring back
  // StringMatcher getSuperfluousWordMatcher();
}

abstract interface class IParser {
  ParseResult? parse(ExtractResult extractResult);
}

class ParseResult extends ExtractResult {
  factory ParseResult.fromExtractResult(ExtractResult extractResult) {
    return ParseResult(
      start: extractResult.start,
      length: extractResult.length,
      text: extractResult.text,
      type: extractResult.type,
      data: extractResult.data,
      metadata: extractResult.metadata,
    );
  }

  ParseResult({
    required super.start,
    required super.length,
    required super.text,
    super.type,
    super.data,
    this.value,
    this.resolutionStr,
    super.metadata,
  });

  // Value is for resolution.
  // e.g. 1000 for "one thousand".
  // The resolutions are different for different parsers.
  // Therefore, we use object here.
  Object? value;

  // Output the value in string format.
  // It is used in some parsers.
  String? resolutionStr;

  /// Serialized this [ParseResult] into a form that can be compared with JSON test cases.
  @override
  Map<String, dynamic> toTestCaseJson() {
    return {
      ...super.toTestCaseJson(),
      if (value != null) //
        "Value": value is DateTimeResolutionResult ? (value as DateTimeResolutionResult).toTestCaseJson() : value,
      if (resolutionStr != null && resolutionStr!.isNotEmpty) //
        "resolutionStr": resolutionStr,
    };
  }
}
