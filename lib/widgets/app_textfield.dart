import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final textInputType;
  double iconHeight;
  double iconWidth;
  bool isObscure;
  Color? textfieldBackgroundColor;
  Color? hintTextColor;
  double hintTextFontSize;
  bool readOnly;
  final void Function(String)? onChanged;

  AppTextField({
    Key? key,
    required this.hintText,
    required this.textInputType,
    this.isObscure = false,
    this.iconHeight = 10,
    this.iconWidth = 10,
    this.textfieldBackgroundColor = Colors.white,
    this.hintTextColor = const Color.fromRGBO(171, 164, 165, 1),
    this.readOnly = false,
    this.hintTextFontSize = 17, this.onChanged,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.textfieldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextField(
          obscureText: _isPressed ? (widget.isObscure ? true : false) : false,
          keyboardType: widget.textInputType,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: widget.hintTextColor,
                fontFamily: 'Publica Sans Round',
                fontSize: widget.hintTextFontSize),
            hintText: widget.hintText,
            prefixIcon: Container(
                // height: 20,
                width: 76.13,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10.23,),
                Container(
                  height: 30,
                  child:  VerticalDivider(
                    color: widget.hintTextColor,
                    thickness: 2,
                  ),
                )
              ],
            )),
            // suffixIcon: widget.isObscure
            //     ? GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _isPressed = !_isPressed;
            //       });
            //     },
            //     child: Image.asset("assets/Hide.png"))
            //     : Container(
            //   width: 2,
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height / 75.27),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.white,
              ),
            ),

          ),
          onSubmitted: widget.onChanged,
        ),
      ),
    );
  }
}
