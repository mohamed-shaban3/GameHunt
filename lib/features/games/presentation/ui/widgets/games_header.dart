import 'package:flutter/material.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/styles.dart';

class GamesHeader extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onNotificationTap;

  const GamesHeader({
    super.key,
    this.onSearchChanged,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.appName, style: TextStyles.font24BoldWhite),
                  Text(AppStrings.appSubtitle, style: TextStyles.font12Grey),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorsManager.borderDark),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: ColorsManager.textPrimary),
                  onPressed: onNotificationTap ?? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No new notifications')),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          // Search Input Field
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: ColorsManager.surfaceDark,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ColorsManager.borderDark),
            ),
            child: TextField(
              onChanged: onSearchChanged,
              style: const TextStyle(color: ColorsManager.textPrimary, fontSize: 14),
              cursorColor: ColorsManager.accentNeon,
              decoration: const InputDecoration(
                hintText: AppStrings.searchHint,
                hintStyle: TextStyles.font12Grey,
                prefixIcon: Icon(Icons.search, color: ColorsManager.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}