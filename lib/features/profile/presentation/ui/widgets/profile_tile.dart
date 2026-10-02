import 'package:flutter/material.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final String? trailingText;
  final Widget? trailingWidget;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.trailingText,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.borderDark),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          icon,
          color: iconColor ?? ColorsManager.accentNeon,
        ),
        title: Text(
          title,
          style: TextStyles.font16WhiteSemiBold.copyWith(
            color: titleColor ?? ColorsManager.textWhite,
          ),
        ),
        trailing: trailingWidget ??
            (trailingText != null
                ? Text(
                    trailingText!,
                    style: TextStyles.font14GreyRegular,
                  )
                : const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: ColorsManager.textGrey,
                  )),
      ),
    );
  }
}