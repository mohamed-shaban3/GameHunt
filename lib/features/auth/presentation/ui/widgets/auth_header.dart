import 'package:flutter/material.dart';
import 'package:gamehunt/core/theme/styles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font24WhiteBold,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyles.font14GreyRegular,
        ),
      ],
    );
  }
}