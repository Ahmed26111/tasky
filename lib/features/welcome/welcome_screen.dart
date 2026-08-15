import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/navigation/main_screen.dart';

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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          top: 9,
                          bottom: 9,
                        ),
                        child: CustomSvgPictureAsset(
                          path: 'assets/images/logo.svg',
                          width: 42,
                          height: 42,
                        ),
                      ),
                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          top: 2,
                          bottom: 2,
                        ),
                        child: Text(
                          'Welcome to Tasky',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      CustomSvgPictureAsset(
                        path: 'assets/images/waving_hand.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomSvgPictureAsset(
                    path: 'assets/images/pana.svg',
                    width: 216,
                    height: 204,
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        SizedBox(height: 24),
                        FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await SharedPreferencesManager().setString(
                                'username',
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
