import 'package:flutter/material.dart';
import 'package:zoomba/utils/text_styles.dart';

class AppTextFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLines;

  const AppTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  /// keeps track of the mouse focus on the text field
  late FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    /// listen to the focus change and update the state
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title text
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        /// Text field
        Container(
            decoration: BoxDecoration(boxShadow: [
              isFocused
                  ? BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 7,
                      spreadRadius: 2,
                    )
                  : BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
            ]),
            child: TextFormField(
              style: AppTextStyle.hintTextStyle(color: Colors.black),
              validator: widget.validator,
              focusNode: focusNode,
              obscureText: widget.obscureText,
              controller: widget.controller,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: widget.hintText,
                hintStyle: AppTextStyle.hintTextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1)),
              ),
            )),
      ],
    );
  }
}
