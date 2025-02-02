import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextInputStyle {
  none,
  fill,
  outline,
  underline,
}

enum TextInputFormat {
  password,
  decimal,
  number,
  phone,
  email,
  text,
}

class TextInputComponent extends StatelessWidget {
  const TextInputComponent({
    super.key,
    this.hint,
    this.label,
    this.backgroundColor,
    this.controller,
    this.style = TextInputStyle.underline,
    this.format = TextInputFormat.text,
    this.labelBehavior,
    this.regexFormatList = const [],
    this.leading,
    this.trailing,
    this.onValidate,
  });

  final String? hint;
  final String? label;
  final Color? backgroundColor;
  final TextInputStyle style;
  final TextInputFormat format;
  final TextEditingController? controller;
  final FloatingLabelBehavior? labelBehavior;
  final List<String> regexFormatList;
  final Widget? leading;
  final Widget? trailing;
  final String? Function(String?)? onValidate;

  _TextInputStyleModel _initialiseStyleModel(final BuildContext context) {
    final model = _TextInputStyleModel(
      backgroundColor: backgroundColor,
      floatingLabelBehavior: labelBehavior ?? FloatingLabelBehavior.auto,
      padding: const EdgeInsets.symmetric(vertical: 12),
      inputBorder: InputBorder.none,
    );

    switch(style) {
      case TextInputStyle.none:
        model.floatingLabelBehavior =  FloatingLabelBehavior.never;
        break;
      case TextInputStyle.fill:
        model.padding = const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        );
        model.floatingLabelBehavior =  FloatingLabelBehavior.never;
        model.inputBorder = const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide.none,
        );
        if (backgroundColor == null) {
          if (MediaQuery.of(context).platformBrightness == Brightness.light) {
            model.backgroundColor = const Color(0xFFEEEEEE);
          } else {
            model.backgroundColor = const Color(0x61000000);
          }
        }
        break;
      case TextInputStyle.outline:
        model.padding = const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        );
        model.inputBorder = const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        );
        break;
      case TextInputStyle.underline:
        model.padding = const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        );
        model.inputBorder = const UnderlineInputBorder();
        break;
    }

    return model;
  }

  _TextInputTypeModel _initialiseFormatModel(final BuildContext context) {
    final model = _TextInputTypeModel(
      keyboardCapitalization: TextCapitalization.none,
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.none,
      inputAutoCorrect: false,
      inputFormatRegexList: [
        ...regexFormatList,
      ],
    );

    switch(format) {
      case TextInputFormat.password:
        model.keyboardType = TextInputType.visiblePassword;
        break;
      case TextInputFormat.decimal:
        model.keyboardType = const TextInputType.numberWithOptions(
          decimal: true,
        );
        break;
      case TextInputFormat.number:
        model.keyboardType = TextInputType.number;
        break;
      case TextInputFormat.phone:
        model.keyboardType = TextInputType.phone;
        break;
      case TextInputFormat.email:
        model.keyboardType = TextInputType.emailAddress;
        break;
      case TextInputFormat.text:
        model.keyboardType = TextInputType.text;
        break;
    }

    return model;
  }

  @override
  Widget build(BuildContext context) {
    final styleModel = _initialiseStyleModel(context);
    final formatModel = _initialiseFormatModel(context);

    return TextFormField(
      clipBehavior: Clip.antiAlias,
      controller: controller,
      textInputAction: formatModel.keyboardAction,
      textCapitalization: formatModel.keyboardCapitalization,
      keyboardType: formatModel.keyboardType,
      autocorrect: false,
      validator: onValidate,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: styleModel.padding,
        floatingLabelBehavior: styleModel.floatingLabelBehavior,
        border: styleModel.inputBorder,
        isDense: true,
        fillColor: styleModel.backgroundColor,
        filled: styleModel.backgroundColor is Color,
        prefixIcon: leading,
        suffixIcon: trailing,
      ),
      inputFormatters: [
        for (final regex in formatModel.inputFormatRegexList)
          FilteringTextInputFormatter.allow(RegExp(regex)),
      ],
    );
  }
}

class _TextInputStyleModel {
  _TextInputStyleModel({
    required this.backgroundColor,
    required this.floatingLabelBehavior,
    required this.padding,
    required this.inputBorder,
  });

  Color? backgroundColor;
  FloatingLabelBehavior floatingLabelBehavior;
  EdgeInsets padding;
  InputBorder inputBorder;
}

class _TextInputTypeModel {
  _TextInputTypeModel({
    required this.keyboardCapitalization,
    required this.keyboardAction,
    required this.keyboardType,
    required this.inputAutoCorrect,
    required this.inputFormatRegexList,
  });

  TextCapitalization keyboardCapitalization;
  TextInputAction keyboardAction;
  TextInputType keyboardType;
  List<String> inputFormatRegexList;

  bool inputAutoCorrect = false;
}
