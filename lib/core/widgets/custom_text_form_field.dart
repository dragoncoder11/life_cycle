import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.maxLines=1,
    this.hintText,
    this.prefixIcon,
    this.textInputType,
    this.filled,
    this.filledColor,
    this.borderColor,
    this.controller,
    this.onSaved,
    this.validate,
    this.textStyle,
    this.onTap,
    this.readOnly = false,
    this.onChanged, this.minLines, this.textInputAction,
  });

  final int? maxLines;
  final int? minLines;
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
  final TextInputAction? textInputAction;

  // تحديد اتجاه الكتابة حسب أول حرف عربي أو إنجليزي
  TextDirection _getTextDirection(String text, TextDirection fallback) {
    for (final character in text.runes) {
      final char = String.fromCharCode(character);

      if (RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]').hasMatch(char)) {
        return TextDirection.rtl;
      }

      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        return TextDirection.ltr;
      }
    }

    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final fallbackDirection = Directionality.of(context);

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
      child: controller == null
          ? _buildTextField(fallbackDirection)
          : ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller!,
              builder: (context, value, child) {
                final direction = _getTextDirection(
                  value.text,
                  fallbackDirection,
                );

                return Directionality(
                  textDirection: direction,
                  child: _buildTextField(direction),
                );
              },
            ),
    );
  }

  Widget _buildTextField(TextDirection direction) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.newline,
      minLines: minLines ?? 1,
      textDirection: direction,
      textAlign: TextAlign.start,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      style: textStyle,
      controller: controller,
      onSaved: onSaved,
      validator: validate,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: maxLines ,
      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText ?? 'Enter text...',
        hintStyle: AppTextStyles.interGrey(14, FontWeight.w400),
        prefixIcon: prefixIcon,
        iconColor: AppColors.greyColor,
        filled: filled ?? false,
        fillColor: (filled ?? false)
            ? (filledColor ?? AppColors.whiteColor)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor ?? AppColors.greyColor),
        ),
      ),
    );
  }
}
