import 'package:flutter/material.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/app_fade_slide_animation.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/styles.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool autofocus;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.autofocus = false,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  void _onTextChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFadeSlideAnimation(
      delay: const Duration(milliseconds: 100),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: ColorsManager.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.borderDark),
        ),
        child: TextField(
          controller: widget.controller,
          autofocus: widget.autofocus,
          style: const TextStyle(color: ColorsManager.textPrimary, fontSize: 14),
          cursorColor: ColorsManager.accentNeon,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: AppStrings.searchHint,
            hintStyle: TextStyles.font12Grey,
            prefixIcon: const Icon(Icons.search, color: ColorsManager.textSecondary),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: ColorsManager.textSecondary, size: 18),
                    onPressed: widget.onClear,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}