import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final Function()? onTapFunction;
  final String buttonText;
  const CustomAuthButton(
      {super.key, this.onTapFunction, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(
            0xff3598DB,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),

            const Icon(
              Icons.east,
              color: Colors.white,
            )
            // isRegistering == true
            //     ? const CircularProgressIndicator(
            //         color: Colors.white,
            //       )
            //     : const Icon(
            //         Icons.east,
            //         color: Colors.white,
            //       )
          ],
        ),
      ),
    );
  }
}
