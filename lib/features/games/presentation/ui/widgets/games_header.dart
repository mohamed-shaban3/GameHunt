import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/features/games/presentation/ui/widgets/app_fade_slide_animation.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_state.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/styles.dart';

class GamesHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const GamesHeader({super.key, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return AppFadeSlideAnimation(
      delay: const Duration(milliseconds: 50),
      child: Padding(
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
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      int unreadCount = 0;
                      if (state is NotificationsSuccess) {
                        unreadCount = state.notifications
                            .where((n) => !n.isRead)
                            .length;
                      }

                      return Badge(
                        isLabelVisible: unreadCount > 0,
                        label: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.redAccent,
                        offset: const Offset(-4, 4),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: ColorsManager.textPrimary,
                          ),
                          onPressed: onNotificationTap,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.searchScreen);
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorsManager.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ColorsManager.borderDark),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: ColorsManager.textSecondary),
                    SizedBox(width: 8),
                    Text(AppStrings.searchHint, style: TextStyles.font12Grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
