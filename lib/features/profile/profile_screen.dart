import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import '../../core/constants/storage_key.dart';
import '../../core/shared/hive_storage_manager.dart';
import '../../core/shared/shared_preferences_manager.dart';
import '../tasks/tasks_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _username;
  late String _motivationQuote;
  bool isLoading = true;
  File? selectedImage;
  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadMotivationQuote();
    _loadImage();
  }

  void _loadUsername(){
    setState(() {
      _username = SharedPreferencesManager().getString(StorageKey.usernameKey) ?? 'Guest';
      isLoading = false;
    });
  }

  void _loadMotivationQuote()  {
    setState(() {
      _motivationQuote =
          SharedPreferencesManager().getString(StorageKey.motivationQuoteKey) ??
          "One task at a time. One step closer.";
      isLoading = false;
    });
  }

  void _loadImage(){
    setState(() {
      final String? imagePath = SharedPreferencesManager().getString(StorageKey.imageKey);
      if(imagePath != null){
        selectedImage = File(imagePath);
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: AppSizes.h18),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: (selectedImage == null)
                                ? AssetImage(
                              "assets/images/profile.png",
                            )
                                : FileImage(selectedImage!),
                            radius: AppSizes.r60,
                            backgroundColor: Colors.transparent,
                          ),
                          Positioned(
                            right: 0,
                            bottom: -AppSizes.ph3,
                            child: IconButton.filled(
                              onPressed: (){
                                _showImageSourceDialog(
                                    context,
                                    (image){
                                      setState(() {
                                        selectedImage = File(image.path);
                                      });
                                    }
                                );
                              },
                              style: ThemeController.isDarkThemeMode()
                                  ? IconButton.styleFrom(
                                backgroundColor: const Color(0xFF282828),
                                foregroundColor: const Color(0xFFC6C6C6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSizes.r30),
                                ),
                                side: BorderSide(
                                  color: Color(0xFF6E6E6E),
                                ),
                              )
                                  : IconButton.styleFrom(
                                backgroundColor: const Color(0xFFFFFFFF),
                                foregroundColor: const Color(0xFF6A6A6A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSizes.r30),
                                ),
                                side: BorderSide(
                                    color: const Color(0xFFD1DAD6),
                                    width: 1
                                ),
                              ),
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: AppSizes.r25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.h4),
                      Text(
                        _username,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        _motivationQuote,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: AppSizes.h8),
                ListTile(
                  onTap: () async {
                    final bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserDetailsScreen();
                        },
                      ),
                    );
                    if (result) {
                      _loadUsername();
                      _loadMotivationQuote();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPictureAsset.withColorFilter(
                    path: "assets/images/Profile_Icon.svg",
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: Text("User Details"),
                  trailing: Icon(
                    Icons.arrow_forward,
                    size: AppSizes.r25,
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: AppSizes.r27,
                  ),
                  title: Text("Dark Mode"),
                  trailing: ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context ,ThemeMode value , Widget ? child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (value){
                          ThemeController.toggleTheme();
                        },
                      );
                    }
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    //! remove all data
                    await SharedPreferencesManager().remove(StorageKey.usernameKey);
                    await SharedPreferencesManager().remove(StorageKey.motivationQuoteKey);
                    // await SharedPreferencesManager().remove(StorageKey.tasksKey);
                    await HiveStorageManager().deleteTasks();
                    await SharedPreferencesManager().remove(StorageKey.imageKey);

                    context.read<TasksController>().loadTasks();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (routes) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: AppSizes.r27,
                  ),
                  title: Text("Log Out"),
                  trailing: Icon(
                    Icons.arrow_forward,
                    size: AppSizes.r25,
                  ),
                ),
              ],
            ),
          );
  }

  void _showImageSourceDialog(BuildContext context , Function(XFile) selectedImage){
    showDialog(
      context: context,
      builder: (context)=>SimpleDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Choose Image Source"),
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        children: [
          SimpleDialogOption(
            onPressed: () async{
              Navigator.pop(context);
              final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
              if(imageFile != null){
                selectedImage(imageFile);
                _saveImage(imageFile);
              }
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt_rounded),
                SizedBox(width: AppSizes.w8,),
                Text("Camera")
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: ()async{
              Navigator.pop(context);
              final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if(imageFile != null){
                selectedImage(imageFile);
                _saveImage(imageFile);
              }
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: AppSizes.w8,),
                Text("Gallery")
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveImage(XFile file)async{
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final File newFile = await File(file.path).copy("${appDirectory.path}/${file.name}");
      await SharedPreferencesManager().setString(StorageKey.imageKey, newFile.path);
  }

}
