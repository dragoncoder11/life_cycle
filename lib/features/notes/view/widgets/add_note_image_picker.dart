
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';

class AddNoteImagePicker extends StatelessWidget {
  const AddNoteImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNoteCubit>();
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return BlocBuilder<AddNoteCubit, AddNoteState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Image (Optional)',
              style: AppTextStyles.interWhite(16, FontWeight.w500),
            ),
            verticalSpace(8.h),

            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: GestureDetector(
                    onTap: () => _showImageOptions(context, cubit),
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(12.r),
                        color: AppColors.kPrimaryColor,
                        strokeWidth: 1.3,
                        dashPattern: const [6, 4],
                      ),
                      child: Container(
                        height: 125.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 38.sp,
                              color: AppColors.kPrimaryColor,
                            ),
                            verticalSpace(8.h),
                            Text(
                              'Tap to upload image',
                              style: AppTextStyles.interWhite(
                                14,
                                FontWeight.w600,
                              ),
                            ),
                            verticalSpace(4.h),
                            Text(
                              'Choose from gallery or camera',
                              style: AppTextStyles.interGrey(
                                11,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                if (cubit.selectedImage != null) ...[
                  horizontalSpace(12.w),

                  Expanded(
                    flex: 3,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(
                            cubit.selectedImage!,
                            width: double.infinity,
                            height: 125.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          top: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: cubit.removeImage,
                            child: CircleAvatar(
                              radius: 13.r,
                              backgroundColor: Colors.black87,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 17.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  void _showImageOptions(BuildContext context, AddNoteCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Image',
                  style: AppTextStyles.interWhite(18, FontWeight.w600),
                ),
                verticalSpace(16.h),

                ListTile(
                  leading: Icon(
                    Icons.photo_library_outlined,
                    color: AppColors.kPrimaryColor,
                  ),
                  title: Text(
                    'Gallery',
                    style: AppTextStyles.interWhite(15, FontWeight.w500),
                  ),
                  subtitle: Text(
                    'Choose from your photos',
                    style: AppTextStyles.interGrey(12, FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    cubit.pickImage(ImageSource.gallery);
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.kPrimaryColor,
                  ),
                  title: Text(
                    'Camera',
                    style: AppTextStyles.interWhite(15, FontWeight.w500),
                  ),
                  subtitle: Text(
                    'Take a new photo',
                    style: AppTextStyles.interGrey(12, FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    cubit.pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
