import 'package:flutter/material.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/core/constants/app_strings.dart';

class CurrencySelectionBottomSheet extends StatelessWidget {
  final String currentCurrency;
  final ValueChanged<String> onCurrencySelected;

  const CurrencySelectionBottomSheet({
    super.key,
    required this.currentCurrency,
    required this.onCurrencySelected,
  });

  /// Static helper method لإظهار الـ Bottom Sheet
  static Future<String?> show(BuildContext context, String currentCurrency) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: ColorsManager.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CurrencySelectionBottomSheet(
        currentCurrency: currentCurrency,
        onCurrencySelected: (selected) {
          Navigator.pop(context, selected);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> currencies = [
      AppStrings.usdCurrency,
      AppStrings.eurCurrency,
      AppStrings.egpCurrency,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.selectCurrency,
            style: TextStyles.font18BoldWhite,
          ),
          const SizedBox(height: 16),
          ...currencies.map(
            (currency) => ListTile(
              title: Text(
                currency,
                style: TextStyles.font16WhiteSemiBold,
              ),
              trailing: currentCurrency == currency
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: ColorsManager.accentNeon,
                    )
                  : null,
              onTap: () => onCurrencySelected(currency),
            ),
          ),
        ],
      ),
    );
  }
}