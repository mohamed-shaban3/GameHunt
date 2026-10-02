import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/constants/app_strings.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/core/widgets/app_error_widget.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_state.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.notifications,
          style: TextStyles.font22BoldWhite,
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess &&
                  state.notifications.isNotEmpty) {
                return IconButton(
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    color: ColorsManager.accentNeon,
                  ),
                  tooltip: AppStrings.clearAll,
                  onPressed: () {
                    context.read<NotificationsCubit>().clearAllNotifications();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsInitial || state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorsManager.accentNeon),
            );
          } else if (state is NotificationsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<NotificationsCubit>().fetchNotifications(),
            );
          } else if (state is NotificationsSuccess) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 64,
                      color: ColorsManager.textGrey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStrings.noNotificationsYet,
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NotificationItem(
                  notification: state.notifications[index],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
