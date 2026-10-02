import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/constants/cache_keys.dart';
import 'package:gamehunt/core/local/cache_helper.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/utils/url_launcher_helper.dart';
import '../../../data/models/deal_model.dart';

class GameDealCard extends StatelessWidget {
  final DealModel deal;
  const GameDealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
     
    final String savedCurrency =
      CacheHelper.getData(key: CacheKeys.userCurrency) ?? AppStrings.usdCurrency;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (deal.dealRedirectUrl != null) {
            UrlLauncherHelper.launchUrlString(deal.dealRedirectUrl!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              // تفاصيل اسم العرض والخصم
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deal.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ColorsManager.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (deal.hasDiscount)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.accentNeon.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-${deal.formattedSavings}%',
                          style: const TextStyle(
                            color: ColorsManager.accentNeon,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // الأسعار والأيقونة
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$savedCurrency ${deal.price ?? '0.00'}',
                    style: const TextStyle(
                      color: ColorsManager.accentNeon,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (deal.retailPrice != null &&
                      deal.retailPrice != deal.price)
                    Text(
                      '$savedCurrency ${deal.retailPrice}',
                      style: const TextStyle(
                        color: ColorsManager.textSecondary,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.open_in_new_rounded,
                color: ColorsManager.accentNeon,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
