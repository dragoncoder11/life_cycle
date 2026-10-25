import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel});
final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.editNoteScreen, arguments: noteModel);
        },
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 2,
        spreadRadius: 1,
        offset: const Offset(0, 0),
      ),
    ],
  ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        noteModel.image ?? 'assets/images/icon_logo.png',
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                      horizontalSpace(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noteModel.title,
                              style: AppTextStyles.interBlack(18, FontWeight.bold),
                               overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            verticalSpace(4),
                            Text(
                              noteModel.content,
                              style: AppTextStyles.interGrey(14, FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        noteModel.createdAt.toString().split(' ')[0],
                        style: AppTextStyles.interGrey(12, FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
