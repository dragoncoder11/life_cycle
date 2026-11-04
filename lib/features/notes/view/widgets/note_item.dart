import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';
import 'package:life_cycle/features/notes/view/widgets/hilighted_text.dart';
import 'package:life_cycle/features/notes/view/widgets/text_direction_helper.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        var cubit = context.read<NotesCubit>();

        bool isSelected = cubit.isNoteSelected(noteModel);

        final noteText = (noteModel.title.trim().isNotEmpty ?? false)
            ? noteModel.title
            : noteModel.content;

        final direction = TextDirectionHelper.getDirection(
          noteText,
          fallback: Directionality.of(context),
        );

        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onLongPress: () {
              cubit.toggleNoteSelection(noteModel);
            },
            onTap: () {
              if (cubit.isSelectionMode) {
                cubit.toggleNoteSelection(noteModel);
              } else {
                Navigator.pushNamed(
                  context,
                  Routes.editNoteScreen,
                  arguments: {'note': noteModel, 'cubit': cubit},
                );
              }
            },
            child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.red.withOpacity(0.15)
                      : AppColors.whiteColor,
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Directionality(
                    textDirection: direction,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (noteModel.image != null &&
                                  noteModel.image!.isNotEmpty &&
                                  File(noteModel.image!).existsSync()) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    File(noteModel.image!),
                                    width: double.infinity,
                                    height: 120.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                verticalSpace(6),
                              ],
                              HighlightedText(
                                text: noteModel.title,
                                query: cubit.searchQuery ?? '',
                                style: AppTextStyles.interBlack(
                                  18,
                                  FontWeight.bold,
                                ),
                              ),
                              HighlightedText(
                                text: noteModel.content,
                                query: cubit.searchQuery ?? '',
                                style:
                                    AppTextStyles.interBlack(
                                      14,
                                      FontWeight.w500,
                                    ).copyWith(
                                      color: AppColors.blackColor.withOpacity(
                                        .7,
                                      ),
                                    ),
                                maxLines: 1,
                                showMatchContext: true,
                              ),
                              verticalSpace(6),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text(
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                  style: AppTextStyles.interGrey(
                                    11,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected) ...[
                          horizontalSpace(8),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.red,
                            size: 24,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
