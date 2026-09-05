import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';

import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _motivationQuoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadMotivationQuote();
  }

  void _loadUsername() async {
    setState(() {
      _usernameController.text = SharedPreferencesManager().getString(StorageKey.usernameKey) ?? 'Guest';
    });
  }

  void _loadMotivationQuote() async {
    setState(() {
      _motivationQuoteController.text =
          SharedPreferencesManager().getString(StorageKey.motivationQuoteKey) ??
              "One task at a time. One step closer.";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(16).r,
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _usernameController,
                hintText: "Usama Elgendy",
                title: "User Name",
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Enter Username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h,),
              CustomTextFormField(
                controller: _motivationQuoteController,
                hintText: "One task at a time. One step closer.",
                title: "Motivation Quote",
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Enter Motivation Quote";
                  }
                  return null;
                },
                maxLines: 5,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(4).r,
                child: FilledButton(
                  onPressed: () async {
                    if (_globalKey.currentState?.validate() ?? false){
                       await SharedPreferencesManager().setString(StorageKey.usernameKey, _usernameController.text);
                       await SharedPreferencesManager().setString(StorageKey.motivationQuoteKey, _motivationQuoteController.text);

                       Navigator.pop(context , true);
                    }
                  },
                  child: Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
