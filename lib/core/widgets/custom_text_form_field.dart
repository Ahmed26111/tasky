import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {
        super.key,
        required this.controller,
        required this.hintText,
        required this.title,
        this.maxLines,
        this.validator
      });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText,),
          validator: validator,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
