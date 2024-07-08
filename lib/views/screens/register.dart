import 'dart:developer';

import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  late GlobalKey<FormState> _formKey;

  String? _username;
  String? _password;
  String? _confirmPassword;
  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      log('$_username && $_password && $_confirmPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ImageManager.authBackground),
          ),
        ),
        child: Container(
          width: context.width / 2.2,
          height: context.height / 1.2,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width / 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Register',
                      style: context.textTheme.bodyLarge,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: context.textTheme.displayMedium,
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign in',
                            style: context.textTheme.displayMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.brown),
                          ),
                          onTap: () => Navigator.pop(context),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageManager.akadomenLogo,
                      height: 50.sp,
                      width: 50.sp,
                    ),
                    MyTextFormField(
                      title: 'Your username',
                      hintText: 'Enter your username',
                      onSaved: (data) => _username = data,
                    ),
                    MyTextFormField(
                      title: 'Your password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      onSaved: (data) => _password = data,
                    ),
                    MyTextFormField(
                      title: 'Confirm password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      onSaved: (data) => _confirmPassword = data,
                    ),
                    SizedBox(height: 40.h),
                    MyElevatedButton(
                      title: 'Register',
                      onPressed: _register,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
