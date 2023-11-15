import 'package:chat_app/features/auth/navigator/auth_navigator.dart';
import 'package:chat_app/features/auth/view/register/register_view.dart';
import 'package:chat_app/features/auth/view/widgets/custom_auth_button.dart';
import 'package:chat_app/features/auth/view/widgets/custom_text_field.dart';
import 'package:chat_app/features/auth/view_model/login_view_model.dart';
import 'package:chat_app/features/auth/view_model/register_view_model.dart';
import 'package:chat_app/utils/custom_dialogs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static String routeName = "login-view";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements AuthNavigator {
  final _formKey = GlobalKey<FormState>();
  bool isEmailAddressValid = false;
  bool isPasswordValid = false;
  var email = "";
  var password = "";
  LoginViewModel loginViewModel = LoginViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => loginViewModel,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            // fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/background@3x.png",
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Positioned(
                // right: MediaQuery.of(context).size.width * 0.5,
                left: MediaQuery.of(context).size.width * 0.45,
                top: MediaQuery.of(context).size.width * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          onChangedFunction: (value) {
                            email = value;
                            if (!EmailValidator.validate(value)) {
                              isEmailAddressValid = false;
                            } else {
                              isEmailAddressValid = true;
                            }
                            setState(() {});
                          },
                          isValid: isEmailAddressValid,
                          labelText: "Email",
                          validatorFunction: (value) {
                            if (value == null && value!.isEmpty) {
                              return "Email should not be empty";
                            }
                            if (!EmailValidator.validate(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextField(
                          obscureText: true,
                          onChangedFunction: (value) {
                            password = value;
                            if (value.length < 6) {
                              isPasswordValid = false;
                            } else {
                              isPasswordValid = true;
                            }

                            setState(() {});
                          },
                          isValid: isPasswordValid,
                          labelText: "Password",
                          validatorFunction: (value) {
                            if (value == null && value!.isEmpty) {
                              return "Password should not be empty";
                            }
                            if (value.length < 6) {
                              return "Password should be at least 6 characters";
                            }
                            return null;
                          },
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return CustomAuthButton(
                              isLoading: viewModel.isLoging,
                              buttonText:
                                  viewModel.isLoging ? "Joining..." : "Login",
                              onTapFunction: () {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.firebaseLogin(
                                      email: email, password: password);
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RegisterView.routeName);
                              },
                              child: Text(
                                "Don't have an account? Create one",
                                style: TextStyle(
                                    color: Color(0xff3598DB),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void navigate() {
    // TODO: implement navigate
  }

  @override
  void showFailureDialog({required String title, required String desc}) {
    CustomDialogs.showFailureDialog(context: context, title: title, desc: desc);
  }

  @override
  void showSuccessDialog({required String title, required String desc}) {
    CustomDialogs.showSuccessDialog(context: context, title: title, desc: desc);
  }
}
