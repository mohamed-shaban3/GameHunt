import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamehunt/core/routes/app_routes.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/core/theme/styles.dart';
import 'package:gamehunt/features/notifications/data/models/notification_model.dart';
import 'package:gamehunt/features/notifications/presentation/cubit/notifications_cubit.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: ColorsManager.textWhite),
      ),
      onDismissed: (_) {
        if (notification.id != null) {
          context.read<NotificationsCubit>().deleteNotification(
            notification.id!,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : ColorsManager.darkBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? ColorsManager.textSecondary.withValues(alpha: 0.2)
                : ColorsManager.accentNeon,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: ColorsManager.accentNeon.withValues(alpha: 0.15),
            child: const Icon(
              Icons.notifications_active,
              color: ColorsManager.accentNeon,
            ),
          ),
          title: Text(
            notification.title,
            style: notification.isRead
                ? TextStyles.font16WhiteSemiBold
                : TextStyles.font18BoldWhite,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(notification.body, style: TextStyles.font14GreyRegular),
              const SizedBox(height: 6),
              Text(
                notification.createdAt.split('T').first,
                style: TextStyles.font12Grey,
              ),
            ],
          ),
          onTap: () {
            if (!notification.isRead && notification.id != null) {
              context.read<NotificationsCubit>().markAsRead(notification.id!);
            }

            if (notification.gameId != null) {
              Navigator.pushNamed(
                context,
                AppRoutes.gameDetailsScreen,
                arguments: notification.gameId,
              );
            }
          },
        ),
      ),
    );
  }
}
