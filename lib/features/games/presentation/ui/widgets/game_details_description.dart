import 'package:flutter/material.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';

class GameDetailsDescription extends StatefulWidget {
  final String? description;
  const GameDetailsDescription({super.key, this.description});

  @override
  State<GameDetailsDescription> createState() => _GameDetailsDescriptionState();
}

class _GameDetailsDescriptionState extends State<GameDetailsDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = (widget.description != null && widget.description!.trim().isNotEmpty)
        ? widget.description!
        : AppStrings.noDescriptionAvailable;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.about,
          style: TextStyle(
            color: ColorsManager.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedCrossFade(
          firstChild: Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ColorsManager.textSecondary,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          secondChild: Text(
            text,
            style: const TextStyle(
              color: ColorsManager.textSecondary,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        if (text.length > 200)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                isExpanded ? 'Show Less' : 'Read More',
                style: const TextStyle(
                  color: ColorsManager.accentNeon,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }
}