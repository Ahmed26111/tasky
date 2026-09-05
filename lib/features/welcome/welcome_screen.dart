import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: AppSizes.pw16,
                          top: AppSizes.ph9,
                          bottom: AppSizes.ph9,
                        ),
                        child: CustomSvgPictureAsset(
                          path: 'assets/images/logo.svg',
                          width: AppSizes.w42,
                          height: AppSizes.h42,
                        ),
                      ),
                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(
                          right: AppSizes.pw8,
                          top: AppSizes.ph2,
                          bottom: AppSizes.ph2,
                        ),
                        child: Text(
                          'Welcome to Tasky',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      CustomSvgPictureAsset(
                        path: 'assets/images/waving_hand.svg',
                        width: AppSizes.w28,
                        height: AppSizes.h28,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: AppSizes.sp16
                    ),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomSvgPictureAsset(
                    path: 'assets/images/pana.svg',
                    width: AppSizes.w216,
                    height: AppSizes.h204,
                  ),
                  SizedBox(height: AppSizes.h28),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: _nameController,
                          hintText: 'e.g. Sarah Khalid',
                          title: "Full Name",
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.h24),
                        FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await SharedPreferencesManager().setString(
                                StorageKey.usernameKey,
                                _nameController.text,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                      "Please Enter a Name",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    )
                                )
                              );
                            }
                          },
                          child: Text('Let’s Get Started'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
