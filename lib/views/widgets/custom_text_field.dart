import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.keyboardType,
    this.icon,
    this.title,
    this.isVisible,
    this.isVisibleColor,
    this.obscureText,
    this.initialValue,
  });
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? isVisible;
  final Color? isVisibleColor;
  final bool? obscureText;
  final String? initialValue;
  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
        child: Text(
          widget.title ?? "",
          style: context.textTheme.bodySmall?.copyWith(fontSize: 14.spMin),
        ),
      ),
      TextFormField(
        initialValue: widget.initialValue,
        style: context.textTheme.bodySmall?.copyWith(color: ColorManager.brown),
        cursorColor: ColorManager.brown,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText ??
            (widget.isVisible == true ? isObscure : false),
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "${widget.title} cannot be empty";
              } else {
                return null;
              }
            },
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          errorMaxLines: 2,
          errorStyle: context.textTheme.bodySmall
              ?.copyWith(color: ColorManager.error, fontSize: 16.spMin),
          suffixIcon: widget.isVisible == true
              ? _buildSuffixIcon(Icons.visibility_off, Icons.visibility)
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10),
          filled: true,
          fillColor: ColorManager.white,
          hintText: widget.hintText,
          hintStyle: context.textTheme.bodySmall,
          enabledBorder: context.inputDecoration.enabledBorder,
          focusedBorder: context.inputDecoration.focusedBorder,
          errorBorder: context.inputDecoration.errorBorder,
          focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
        ),
      )
    ]);
  }

  Widget _buildSuffixIcon(IconData icon1, IconData icon2) {
    return IconButton(
      onPressed: () {
        isObscure = !isObscure;
        setState(() {});
      },
      icon: Icon(isObscure == true ? icon1 : icon2),
      color: ColorManager.brown,
      iconSize: 7.sp,
    );
  }
}
