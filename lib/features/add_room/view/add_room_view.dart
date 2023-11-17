import 'package:chat_app/features/add_room/navigator/add_room_navigator.dart';
import 'package:chat_app/features/add_room/view/widgets/add_custom_text_field.dart';
import 'package:chat_app/features/add_room/view_model/add_room_view_model.dart';
import 'package:chat_app/model/room_category.dart';
import 'package:chat_app/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddRoomView extends StatefulWidget {
  static String routeName = "add-room";
  const AddRoomView({super.key});

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> implements AddRoomNavigator {
  AddRoomViewModel addRoomViewModel = AddRoomViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addRoomViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRoomViewModel>(
      create: (context) {
        return addRoomViewModel;
      },
      child: Consumer<AddRoomViewModel>(
        builder: (context, addRoomViewModel, _) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/background@3x.png",
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Add new room",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                    padding: EdgeInsets.only(
                        top: 25.h, left: 25.w, right: 25.w, bottom: 50.h),
                    width: double.infinity,
                    // height: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(
                              0,
                              5,
                            ),
                          ),
                        ]),
                    child: Form(
                      key: addRoomViewModel.formKey,
                      child: Column(
                        children: [
                          Text(
                            "Create New Room",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Image.asset(
                            "assets/images/room@3x.png",
                            width: 160.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          AddCustomTextField(
                            textEditingController:
                                addRoomViewModel.roomNameController,
                            text: "Enter room name",
                            validatorFunction:
                                addRoomViewModel.roomNameValidatorFunc,
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          DropdownButton<RoomCategory>(
                            value: addRoomViewModel.selectedCategory,
                            isExpanded: true,
                            // onChanged: (value) {
                            //   addRoomViewModel.selectedCategory =
                            //       value ?? addRoomViewModel.selectedCategory;
                            // },
                            onChanged: addRoomViewModel.onCategoryChanged,
                            items:
                                addRoomViewModel.chatCategories.map((category) {
                              return DropdownMenuItem<RoomCategory>(
                                // value: category,
                                value: category,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(category.name),
                                    Center(
                                      child: Image.asset(
                                        category.image,
                                        width: 35.h,
                                        height: 35.h,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          AddCustomTextField(
                            textEditingController:
                                addRoomViewModel.roomDescController,
                            text: "Enter room description",
                            maxLines: 10,
                            minLines: 3,
                            validatorFunction:
                                addRoomViewModel.roomDescValidatorFunc,
                          ),
                          SizedBox(
                            height: 75.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: MyTheme.primaryColor,
                              ),
                              onPressed: () async {
                                if (addRoomViewModel.isCreating == false) {
                                  await addRoomViewModel.createRoom();
                                }
                              },
                              child: addRoomViewModel.isCreating
                                  ? SizedBox(
                                      width: 25.w,
                                      height: 25.w,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Create",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void backToHome() {
    Navigator.pop(context);
  }
}
