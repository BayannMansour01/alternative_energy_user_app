import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final String? hintText, labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? suffixIconOnTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool disableFocusNode;
  final int? maxLines;
  final int? maxLength;
  final String? initialValue;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final Color? outLineBorderColor;
  final bool noOutlineBorder;
  const CustomTextField({
    super.key,
    this.noOutlineBorder = false,
    this.outLineBorderColor,
    this.disableFocusNode = false,
    this.width,
    this.hintText,
    this.suffixIconOnTap,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.initialValue,
    this.autofocus = false,
    this.maxLength,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? SizeConfig.defaultSize * 26,
      child: TextFormField(
        cursorColor: AppConstants.blueColor,
        autofocus: autofocus,
        initialValue: initialValue,
        focusNode: disableFocusNode ? AlwaysDisabledFocusNode() : null,
        textInputAction: textInputAction,
        obscureText: obscureText ?? false,
        onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator ??
            (value) {
              if (value?.isEmpty ?? true) {
                return 'املأ الحقل من فضلك';
              } else if (keyboardType == TextInputType.emailAddress) {
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.toString())) {
                  return "الرجاء إدخال بريد الكتروني صالح ";
                }
              }
              return null;
            },
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 5, 74, 131),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),

          prefixIconColor: Color.fromARGB(255, 5, 74, 131),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          //   borderSide: BorderSide(
          //     color: Colors.blue, // اللون عند التركيز
          //     width: 2.0,
          //   ),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          //   borderSide: BorderSide(
          //     color: Colors.grey, // اللون عندما لا يكون هناك تركيز
          //     width: 2.0,
          //   ),
          // ),
          focusedBorder: getOutLineInputBorder(),
          enabledBorder: noOutlineBorder ? getOutLineInputBorder() : null,
          border: getOutLineInputBorder(),
        ),
      ),
    );
  }

  UnderlineInputBorder getUnderLineInputBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red),
    );
  }

  OutlineInputBorder getOutLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: outLineBorderColor ?? const Color.fromARGB(255, 3, 90, 161),
        style: BorderStyle.solid,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
