import 'package:chat_app/features/auth/view/widgets/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatefulWidget {
  static String routeName = "register-view";
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  bool isValidName = false;
  bool isEmailAddressValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;
  bool isRegistering = false;

  var firstName = "";
  var email = "";
  var password = "";
  var confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset("assets/images/background@3x.png"),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Create Account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    onChangedFunction: (value) {
                      firstName = value;
                      if (value.length < 6) {
                        isValidName = false;
                      } else {
                        isValidName = true;
                      }
                      setState(() {});
                    },
                    isValid: isValidName,
                    labelText: "First name",
                    validatorFunction: (value) {
                      if (value == null && value!.isEmpty) {
                        return "Name should not be empty";
                      }
                      if (value.length < 6) {
                        return "Name should be at least 6 characters";
                      }
                      return null;
                    },
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    height: 20,
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
                      if (confirmPassword == password &&
                          (confirmPassword.isNotEmpty || password.isNotEmpty)) {
                        isConfirmPasswordValid = true;
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
                  CustomTextField(
                    obscureText: true,
                    onChangedFunction: (value) {
                      confirmPassword = value;
                      if (confirmPassword == password) {
                        isConfirmPasswordValid = true;
                      } else {
                        isConfirmPasswordValid = false;
                      }
                      setState(() {});
                    },
                    isValid: isConfirmPasswordValid,
                    labelText: "Confirm password",
                    validatorFunction: (value) {
                      if (confirmPassword != password) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    textInputType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
