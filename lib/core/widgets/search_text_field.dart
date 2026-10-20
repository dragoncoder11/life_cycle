import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: searchFocusNode,
      builder: (context, child) {
        final hasFocus = searchFocusNode.hasFocus;
        return TextFormField(
          focusNode: searchFocusNode,
          maxLines: 1,
          cursorColor: AppColors.kPrimaryColor,
          decoration: InputDecoration(
            hintText: 'Search notes...',
            hintStyle: AppTextStyles.interGrey(14, FontWeight.w400),
            prefixIcon: Icon(
              Icons.search,
              color: hasFocus
                  ? AppColors.kPrimaryColor
                  : AppColors.textSecondary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.textSecondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.kPrimaryColor,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.textSecondary),
            ),
          ),
        );
      },
    );
  }
}
