import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_styles.dart';

class CustomSearchableDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final void Function(String)? onSearchChanged;
  final FormFieldValidator<dynamic>? validator;
  final String? errorText;

  const CustomSearchableDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
    this.onSearchChanged,
    this.validator,
    this.errorText,
  });

  @override
  State<CustomSearchableDropdown<T>> createState() =>
      _CustomSearchableDropdownState<T>();
}

class _CustomSearchableDropdownState<T>
    extends State<CustomSearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    widget.onSearchChanged?.call(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<T>(
          value: widget.value,
          isExpanded: true,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            labelStyle: TextStyles.regular14.copyWith(
              color: AppColors.border.withOpacity(0.6),
            ),
            hintStyle: TextStyles.regular14.copyWith(
              color: AppColors.border.withOpacity(0.6),
            ),
            errorText: widget.errorText,
            border: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
              borderSide: BorderSide(
                color: AppColors.border,
                width: 1,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
              borderSide: BorderSide(
                color: AppColors.border,
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
              borderSide: BorderSide(
                color: AppColors.danger,
                width: 1,
              ),
            ),
            // prefixIcon: const Icon(Icons.search),
            // suffixIcon: IconButton(
            //   icon: const Icon(Icons.arrow_drop_down),
            //   onPressed: () {
            //     setState(() {
            //       _isExpanded = !_isExpanded;
            //       if (_isExpanded) {
            //         _focusNode.requestFocus();
            //       }
            //     });
            //   },
            // ),
          ),
          items: [
            DropdownMenuItem<T>(
              value: null,
              enabled: false,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyles.regular14.copyWith(
                    color: AppColors.border.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            ...widget.items,
          ],
          onChanged: (value) {
            if (value != null) {
              widget.onChanged?.call(value);
              setState(() {
                _isExpanded = false;
              });
            }
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
