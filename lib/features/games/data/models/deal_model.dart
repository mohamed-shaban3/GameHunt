import '../../../../core/constants/api_constants.dart';

class DealModel {
  final String? dealID;
  final String? title;
  final String? price;
  final String? retailPrice;
  final double? savings;

  const DealModel({
    this.dealID,
    this.title,
    this.price,
    this.retailPrice,
    this.savings,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      dealID: json['dealID'] as String?,
      title: json['title'] as String?,
      price: (json['salePrice'] ?? json['price']) as String?,
      retailPrice: (json['normalPrice'] ?? json['retailPrice']) as String?,
      savings: double.tryParse(json['savings']?.toString() ?? ''),
    );
  }

  int get formattedSavings => savings?.round() ?? 0;
  bool get hasDiscount => formattedSavings > 0;

  // الرابط الخاص بالتحويل
  String? get dealRedirectUrl =>
      dealID != null ? '${ApiConstants.cheapSharkRedirectUrl}$dealID' : null;
}