import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/register/register_cubit.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/helpers/my_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _passwordController;

  String? _username;
  String? _password;
  String? _confirmPassword;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    super.initState();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context
          .read<RegisterCubit>()
          .register(_username!.trim(), _confirmPassword!.trim());
      _formKey.currentState?.reset();
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
                      controller: _passwordController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        }
                        if (_passwordController.text != value) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    BlocListener<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          customSnackBar(
                              context, 'Registration success, Login now!');
                          Navigator.pop(context);
                        }
                        if (state is RegisterFailure) {
                          customSnackBar(context, 'Registration failed!');
                        }
                        if (state is UsernameTaken) {
                          customSnackBar(context, 'Username already taken!');
                        }
                      },
                      child: MyElevatedButton(
                        title: 'Register',
                        onPressed: _register,
                      ),
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
