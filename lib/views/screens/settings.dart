import 'dart:io';

import 'package:akadomen/utils/constants/routes.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/logout/logout_cubit.dart';
import '../../controllers/image/image_cubit.dart';
import '../../controllers/repo/fruits_repository.dart';
import '../../models/juice.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/helpers/my_snackbar.dart';
import '../../utils/helpers/shared_pref.dart';
import '../../views/widgets/custom_button.dart';

import '../widgets/custom_text_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String _userName = CacheData.getData(key: 'currentUser');
  File? _pickedImage;
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: context.width,
            height: context.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageManager.homeBackground),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: context.width / 2.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<PickImageCubit, PickImageState>(
                      listener: (context, state) {
                        if (state is PickImageSuccess) {
                          _pickedImage = state.imagePath;
                        }
                        if (state is PickImageFailure) {
                          customSnackBar(context, state.errMessage);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            overlayColor: const WidgetStatePropertyAll(
                                ColorManager.white),
                            backgroundColor: WidgetStatePropertyAll(
                                ColorManager.white.withOpacity(0.7)),
                            fixedSize: WidgetStatePropertyAll(
                              Size(context.width / 3, context.height / 2),
                            ),
                          ),
                          child: _pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(
                                    width: double.infinity,
                                    height: double.infinity,
                                    _pickedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.add_a_photo_rounded,
                                  size: 20.sp, color: ColorManager.brown),
                          onPressed: () =>
                              context.read<PickImageCubit>().pickImage(),
                        );
                      },
                    ),
                  ],
                ),
                _buildJuiceForm(context)
              ],
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: Column(
              children: [
                IconButton(
                  hoverColor: ColorManager.white,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      ColorManager.white.withOpacity(0.7),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    size: 7.sp,
                    Icons.arrow_back,
                    color: ColorManager.brown,
                  ),
                ),
                SizedBox(height: 10.h),
                Tooltip(
                  margin: const EdgeInsets.only(top: 5),
                  height: 34,
                  message: 'Logout',
                  decoration: BoxDecoration(
                      color: ColorManager.brown,
                      borderRadius: BorderRadius.circular(4)),
                  child: BlocListener<AuthStatus, AuthStatusState>(
                    listener: (context, state) {
                      if (state is Logout) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteManager.login, (route) => false);
                        customSnackBar(context, 'Logout Successfully!');
                      }

                      if (state is LogoutFailure) {
                        customSnackBar(context, 'There was an error!');
                      }
                    },
                    child: IconButton(
                      hoverColor: ColorManager.white,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          ColorManager.white.withOpacity(0.7),
                        ),
                      ),
                      icon: Icon(
                        size: 7.sp,
                        Icons.logout,
                        color: ColorManager.brown,
                      ),
                      onPressed: () {
                        context.read<AuthStatus>().logout();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(right: context.width / 30),
              width: context.width / 3,
              height: context.height / 1.2,
              decoration: BoxDecoration(
                color: ColorManager.white,
                // borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, -1),
                    color: ColorManager.brown.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildJuiceList(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJuiceForm(BuildContext context) {
    return SizedBox(
      width: context.width / 3,
      child: Column(
        children: [
          MyTextFormField(
            controller: _nameController,
            hintText: 'Juice Name',
          ),
          MyTextFormField(
            height: 5,
            controller: _priceController,
            keyboardType: TextInputType.number,
            hintText: 'Price',
          ),
          SizedBox(height: 20.h),
          MyElevatedButton(
            title: 'Add Juice',
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty &&
                  _pickedImage != null) {
                final name = _nameController.text;
                final price = int.tryParse(_priceController.text) ?? 0;
                final image = _pickedImage!.path;
                context
                    .read<FruitsRepositoryCubit>()
                    .addUserJuice(name, price, image);
                _clearForm();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJuiceList(BuildContext context) {
    return BlocBuilder<FruitsRepositoryCubit, List<JuiceModel>>(
      builder: (context, juices) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: juices.map((juice) => _buildJuiceItem(juice)).toList(),
        );
      },
    );
  }

  Widget _buildJuiceItem(JuiceModel juice) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: FileImage(File(juice.image!)),
      ),
      title: Text(
        juice.name,
        style: context.textTheme.bodyLarge,
      ),
      subtitle: Text(
        '\$${juice.price}',
        style: context.textTheme.displayMedium,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 7.sp,
          color: ColorManager.brown,
        ),
        onPressed: () => _showConfirmationDialog(juice),
      ),
    );
  }

  void _showConfirmationDialog(JuiceModel juice) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: ColorManager.white,
          title: Text(
            'Remove ${juice.name}?',
            style: context.textTheme.bodyLarge,
          ),
          content: Text(
            'Are you sure you want to remove this juice?',
            style: context.textTheme.displayMedium,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(
                    ColorManager.correct.withOpacity(0.3)),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: context.textTheme.displayMedium
                    ?.copyWith(color: ColorManager.correct),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor:
                    WidgetStatePropertyAll(ColorManager.error.withOpacity(0.3)),
              ),
              onPressed: () {
                _removeJuice(juice);
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Remove',
                style: context.textTheme.displayMedium
                    ?.copyWith(color: ColorManager.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _removeJuice(JuiceModel juice) {
    context.read<FruitsRepositoryCubit>().removeUserJuice(juice.name);
  }

  void _clearForm() {
    _nameController.clear();
    _priceController.clear();
    setState(() {
      _pickedImage = null;
    });
  }
}
