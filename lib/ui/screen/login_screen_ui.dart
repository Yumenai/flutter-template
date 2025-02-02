import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utility/format_utility.dart';
import '../component/button/text_button_component_ui.dart';
import '../component/text_input_component.dart';
import '../widget/app_avatar_widget.dart';

class LoginScreenUi extends StatefulWidget {
  const LoginScreenUi.email({
    super.key,
    required final void Function(BuildContext, String) onLogin,
  })  : _isEmailMode = true,
        _isPhoneMode = false,
        onLoginEmail = onLogin,
        onLoginPhone = null,
        onUpdatePhoneCode = null;

  const LoginScreenUi.phone({
    super.key,
    required final void Function(BuildContext, String, String) onLogin,
    required this.onUpdatePhoneCode,
  })  : _isEmailMode = false,
        _isPhoneMode = true,
        onLoginEmail = null,
        onLoginPhone = onLogin;

  final void Function(BuildContext, String)? onLoginEmail;
  final void Function(BuildContext, String, String)? onLoginPhone;
  final Future<String?> Function(BuildContext)? onUpdatePhoneCode;
  final bool _isEmailMode;
  final bool _isPhoneMode;

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi> {
  final formKey = GlobalKey<FormState>();
  final phoneCodeNotifier = ValueNotifier('');
  final inputController = TextEditingController();

  @override
  void dispose() {
    phoneCodeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 24,
          ),
          children: [
            const AppAvatarWidget(
              title: 'Login',
            ),
            const SizedBox(
              height: 24,
            ),
            ..._buildHeaderForm(),
            const SizedBox(
              height: 12,
            ),
            _buildInputForm(),
            const SizedBox(
              height: 48,
            ),
            TextButtonComponentUi.submit(
              text: const Text('Login'),
              onTap: _login,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHeaderForm() {
    final String title;
    final String message;

    if (widget._isEmailMode) {
      title = 'Enter your email address';
      message = 'You will receive an email with 4 digit code for email verification';
    } else if (widget._isPhoneMode) {
      title = 'Enter your phone number';
      message = 'You will receive an sms with 4 digit code for phone verification';
    } else {
      title = 'Unknown Mode';
      message = 'Error, mode unknown';
    }

    return [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 4),
      Text(message),
    ];
  }

  Widget _buildInputForm() {
    if (widget._isEmailMode) {
      return Form(
        key: formKey,
        child: TextInputComponent(
          label: 'Email',
          hint: 'example@domain.com',
          style: TextInputStyle.outline,
          format: TextInputFormat.email,
          controller: inputController,
          onValidate: _validateInputForm,
        ),
      );
    } else if (widget._isPhoneMode) {
      return Form(
        key: formKey,
        child: TextInputComponent(
          label: 'Phone',
          hint: '12456789',
          leading: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ValueListenableBuilder(
              valueListenable: phoneCodeNotifier,
              builder: (context, phoneCode, child) {
                return TextButton(
                  onPressed: _updatePhoneCode,
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                  ),
                  child: Text('+$phoneCode'),
                );
              },
            ),
          ),
          style: TextInputStyle.outline,
          format: TextInputFormat.phone,
          controller: inputController,
          onValidate: _validateInputForm,
        ),
      );
    }

    return const SizedBox();
  }

  void _login() {
    if (formKey.currentState?.validate() != true) return;

    if (widget._isEmailMode) {
      widget.onLoginEmail?.call(
        context,
        inputController.text.trim(),
      );
    } else if (widget._isPhoneMode) {
      widget.onLoginPhone?.call(
        context,
        inputController.text.trim(),
        phoneCodeNotifier.value,
      );
    }
  }

  void _updatePhoneCode() async {
    final value = await widget.onUpdatePhoneCode?.call(
      context,
    );

    if (value == null || value.isEmpty) return;

    phoneCodeNotifier.value = value;
  }

  String? _validateInputForm(final String? text) {
    if (text?.isEmpty ?? true) {
      return 'Please filled in the text fields';
    } else if (!FormatUtility.isEmail(text) && widget._isEmailMode) {
      return 'Please fill in the correct email format example@domain.com';
    } else if (!FormatUtility.isPhone(text) && widget._isPhoneMode) {
      return 'Please fill in the correct phone format 123456789';
    }

    return null;
  }
}
