class ApiErrorModel {
  final String? message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  ApiErrorModel({
    this.message,
    this.statusCode,
    this.errors,
  });

  factory ApiErrorModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      // معالجة الرسالة في حال وجودها تحت مسميات مختلفة (message, error, detail)
      String? extractedMessage = json['message'] as String? ??
          json['error'] as String? ??
          json['detail'] as String?;

      // في حال كانت الأخطاء داخل قائمة أو كائن فرعي (Validation Errors)
      if (extractedMessage == null && json['errors'] != null) {
        if (json['errors'] is Map) {
          final errMap = json['errors'] as Map<String, dynamic>;
          extractedMessage = errMap.values.map((e) => e.toString()).join(', ');
        } else if (json['errors'] is List) {
          extractedMessage = (json['errors'] as List).join(', ');
        }
      }

      return ApiErrorModel(
        message: extractedMessage ?? 'An unexpected error occurred.',
        statusCode: json['status'] as int? ?? json['statusCode'] as int?,
        errors: json['errors'] is Map<String, dynamic>
            ? json['errors'] as Map<String, dynamic>
            : null,
      );
    } else if (json is String && json.isNotEmpty) {
      return ApiErrorModel(message: json);
    }

    return ApiErrorModel(message: 'Something went wrong, please try again.');
  }
}