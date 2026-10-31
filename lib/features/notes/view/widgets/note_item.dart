import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        var cubit = context.read<NotesCubit>();

        bool isSelected = cubit.isNoteSelected(noteModel);

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
                  arguments: {
                    'note': noteModel,
                    'cubit': cubit,
                  },
                );
              }
            },
            child: Card(
              elevation: 3,
              color: isSelected
                  ? Colors.red.withOpacity(0.15)
                  : AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? Colors.red
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      noteModel.image ??
                          'assets/images/icon_logo.png',
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
                            style: AppTextStyles.interBlack(
                              18,
                              FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          verticalSpace(4),

                          Text(
                            noteModel.content,
                            style: AppTextStyles.interGrey(
                              14,
                              FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),

                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.red,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}