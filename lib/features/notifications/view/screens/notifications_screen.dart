// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:life_cycle/core/helper/app_constants.dart';
// import 'package:life_cycle/core/helper/spacing.dart';
// import 'package:life_cycle/core/theme/app_text_styles.dart';

// import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
// import 'package:life_cycle/features/tasks/data/models/task_model.dart';
// import 'package:life_cycle/features/notifications/view/widgets/notification_item.dart';

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   List<NotificationEntry> getNotifications(
//     Box<TaskModel> tasksBox,
//     Box<TransactionModel> transactionsBox,
//   ) {
//     final now = DateTime.now();

//     final List<NotificationEntry> notifications = [];

//     // Expired Tasks
//     for (final task in tasksBox.values) {
//       final endTime = task.endTime;

//       if (endTime != null && !endTime.isAfter(now)) {
//         notifications.add(
//           NotificationEntry(
//             title: 'Task Time Ended',
//             body: 'The time for ${task.title ?? 'Your task'} has ended',
//             date: endTime,
//             icon: Icons.alarm_off_rounded,
//             color: Colors.orange,
//           ),
//         );
//       }
//     }

//     // Added Transactions
//     for (final transaction in transactionsBox.values) {
//       final isIncome = transaction.type == TransactionType.income;

//       final note = transaction.note?.trim() ?? '';

//       notifications.add(
//         NotificationEntry(
//           title: isIncome ? 'Income Added' : 'Expense Added',
//           body: [
//             transaction.title,
//             transaction.amount.toStringAsFixed(2),
//             if (note.isNotEmpty) note,
//           ].join(' • '),
//           date: transaction.date,
//           icon: isIncome
//               ? Icons.trending_up_rounded
//               : Icons.trending_down_rounded,
//           color: isIncome ? Colors.green : Colors.red,
//         ),
//       );
//     }

//     notifications.sort((a, b) => b.date.compareTo(a.date));

//     return notifications;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tasksBox = Hive.box<TaskModel>(kTasksBox);
//     final transactionsBox = Hive.box<TransactionModel>(kTransactionsBox);

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               verticalSpace(12.h),

//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Text(
//                     'Notifications',
//                     style: AppTextStyles.interBlack(24, FontWeight.bold),
//                   ),
//                 ],
//               ),

//               verticalSpace(10),

//               Expanded(
//                 child: ValueListenableBuilder(
//                   valueListenable: tasksBox.listenable(),
//                   builder: (context, tasksValue, child) {
//                     return ValueListenableBuilder(
//                       valueListenable: transactionsBox.listenable(),
//                       builder: (context, transactionsValue, child) {
//                         final notifications = getNotifications(
//                           tasksBox,
//                           transactionsBox,
//                         );

//                         if (notifications.isEmpty) {
//                           return Center(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.notifications_none_rounded,
//                                   size: 65.sp,
//                                   color: Colors.grey,
//                                 ),
//                                 verticalSpace(12),
//                                 Text(
//                                   'No Notifications Yet',
//                                   style: AppTextStyles.interGrey(
//                                     16,
//                                     FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }

//                         return ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           itemCount: notifications.length,
//                           itemBuilder: (context, index) {
//                             final notification = notifications[index];

//                             return NotificationItem(
//                               title: notification.title,
//                               body: notification.body,
//                               date: notification.date,
//                               icon: notification.icon,
//                               iconColor: notification.color,
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NotificationEntry {
//   final String title;
//   final String body;
//   final DateTime date;
//   final IconData icon;
//   final Color color;

//   const NotificationEntry({
//     required this.title,
//     required this.body,
//     required this.date,
//     required this.icon,
//     required this.color,
//   });
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';

import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:life_cycle/features/notifications/view/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  List<NotificationEntry> getNotifications(
    Box<TaskModel> tasksBox,
    Box<TransactionModel> transactionsBox,
  ) {
    final now = DateTime.now();

    final List<NotificationEntry> notifications = [];

    // Expired Tasks
    for (final task in tasksBox.values) {
      final endTime = task.endTime;

      if (endTime != null && !endTime.isAfter(now)) {
        notifications.add(
          NotificationEntry(
            title: 'Task Time Ended',
            body: 'The time for  ${task.title ?? 'Your task'} has ended',
            date: endTime,
            icon: Icons.alarm_off_rounded,
            color: Colors.orange,
          ),
        );
      }
    }

    // Added Transactions
    for (final transaction in transactionsBox.values) {
      final isIncome = transaction.type == TransactionType.income;

      final note = transaction.note?.trim() ?? '';

      notifications.add(
        NotificationEntry(
          title: isIncome ? 'Income Added' : 'Expense Added',
          body: [
            transaction.title,
            transaction.amount.toStringAsFixed(2),
            if (note.isNotEmpty) note,
          ].join(' • '),
          date: transaction.date,
          icon: isIncome
              ? Icons.trending_up_rounded
              : Icons.trending_down_rounded,
          color: isIncome ? Colors.green : Colors.red,
        ),
      );
    }

    notifications.sort((a, b) => b.date.compareTo(a.date));

    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    final tasksBox = Hive.box<TaskModel>(kTasksBox);
    final transactionsBox = Hive.box<TransactionModel>(kTransactionsBox);

    return StatusBarMode(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12.h),
      
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
      
                verticalSpace(10),
      
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: tasksBox.listenable(),
                    builder: (context, tasksValue, child) {
                      return ValueListenableBuilder(
                        valueListenable: transactionsBox.listenable(),
                        builder: (context, transactionsValue, child) {
                          final notifications = getNotifications(
                            tasksBox,
                            transactionsBox,
                          );
      
                          if (notifications.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.notifications_none_rounded,
                                    size: 65.sp,
                                    color: Colors.grey,
                                  ),
                                  verticalSpace(12),
                                  Text(
                                    'No Notifications Yet',
                                    style: AppTextStyles.interGrey(
                                      16,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
      
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final notification = notifications[index];
      
                              return NotificationItem(
                                title: notification.title,
                                body: notification.body,
                                date: notification.date,
                                icon: notification.icon,
                                iconColor: notification.color,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationEntry {
  final String title;
  final String body;
  final DateTime date;
  final IconData icon;
  final Color color;

  const NotificationEntry({
    required this.title,
    required this.body,
    required this.date,
    required this.icon,
    required this.color,
  });
}
