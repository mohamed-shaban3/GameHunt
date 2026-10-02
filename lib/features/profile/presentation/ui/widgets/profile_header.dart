import 'package:flutter/material.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: ColorsManager.accentNeon.withValues(alpha: 0.15),
          child: const Icon(
            Icons.person_rounded,
            size: 50,
            color: ColorsManager.accentNeon,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          userName,
          style: TextStyles.font22BoldWhite,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          userEmail,
          style: TextStyles.font14GreyRegular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}