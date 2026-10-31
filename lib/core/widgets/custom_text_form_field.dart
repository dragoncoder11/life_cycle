import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.maxLines,
    this.hintText,
    this.prefixIcon,
    this.textInputType,
    this.filled,
    this.filledColor,
    this.borderColor,
    this.controller,
    this.onSaved,
    this.validate,
    this.textStyle, this.onTap, this.readOnly=false, this.onChanged,
  });

  final int? maxLines;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final bool? filled;
  final Color? filledColor;
  final Color? borderColor;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validate;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        onChanged: onChanged,
        readOnly:readOnly ,
        onTap: onTap,
        style: textStyle,
        controller: controller,
        onSaved: onSaved,
        validator: validate,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        cursorColor: AppColors.kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText ?? 'Enter text...',
          hintStyle: AppTextStyles.interGrey(14, FontWeight.w400),
          prefixIcon: prefixIcon,
          iconColor: AppColors.textSecondary,
          filled: filled ?? false,
          fillColor: (filled ?? false) ? (filledColor ?? Colors.white) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textSecondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
