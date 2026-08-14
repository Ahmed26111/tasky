import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';

import '../core/shared/shared_preferences_manager.dart';

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
      _usernameController.text = SharedPreferencesManager().getString('username') ?? 'Guest';
    });
  }

  void _loadMotivationQuote() async {
    setState(() {
      _motivationQuoteController.text =
          SharedPreferencesManager().getString('motivation_quote') ??
              "One task at a time. One step closer.";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
              SizedBox(height: 20,),
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
                padding: const EdgeInsets.all(4),
                child: FilledButton(
                  onPressed: () async {
                    if (_globalKey.currentState?.validate() ?? false){
                       await SharedPreferencesManager().setString('username', _usernameController.text);
                       await SharedPreferencesManager().setString('motivation_quote', _motivationQuoteController.text);

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
