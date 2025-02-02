import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../component/button/text_button_component_ui.dart';
import '../component/ticker_component.dart';
import '../widget/app_avatar_widget.dart';

class PinVerificationScreenUi extends StatefulWidget {
  const PinVerificationScreenUi({
    super.key,
    required this.onVerify,
    required this.onRequest,
    this.title = '',
    this.sentTo = '',
    this.lastRequested,
    this.requestFrequency,
    this.pinSize = 5,
  });

  final String title;
  final String sentTo;
  final DateTime? lastRequested;
  final Duration? requestFrequency;
  final int pinSize;
  final void Function(BuildContext, String) onVerify;
  final void Function(BuildContext) onRequest;

  @override
  State<PinVerificationScreenUi> createState() =>
      _PinVerificationScreenUiState();
}

class _PinVerificationScreenUiState extends State<PinVerificationScreenUi> {
  late final _inputControllerList = List.generate(widget.pinSize, (index) {
    return TextEditingController();
  });
  late DateTime _lastOtpRequested = widget.lastRequested ?? DateTime(2000);
  late final _requestFrequency = widget.requestFrequency ??
      const Duration(
        minutes: 1,
      );

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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          shrinkWrap: true,
          children: [
            AppAvatarWidget(
              title: widget.title.isEmpty ? 'Pin Verification' : widget.title,
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter your code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            _buildMessageComponent(),
            const SizedBox(height: 12),
            _buildPinComponent(),
            const SizedBox(height: 24),
            TextButtonComponentUi.submit(
              text: const Text('Verify'),
              onTap: _verifyPin,
            ),
            const SizedBox(height: 12),
            _buildResendComponent(),
          ],
        ),
      ),
    );
  }

  void _verifyPin() {
    FocusScope.of(context).unfocus();
    final pins = <String> [];

    for (final controller in _inputControllerList) {
      pins.add(controller.text.trim());
    }

    widget.onVerify(context, pins.join());
  }

  Widget _buildMessageComponent() {
    return  Wrap(
      children: [
        Text('Please enter the ${widget.pinSize}-digit verification code sent to '),
        Text(
          widget.sentTo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPinComponent() {
    return Wrap(
      spacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(widget.pinSize, (index) {
        final isLastPosition = index == widget.pinSize - 1;
        final inputController = _inputControllerList[index];
        return SizedBox(
          width: 40,
          child: Focus(
            canRequestFocus: false,
            onFocusChange: (isFocus) {
              if (isFocus) {
                inputController.text = '';
              }
            },
            child: TextFormField(
              controller: inputController,
              autofocus: index == 0,
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              textInputAction: isLastPosition ? TextInputAction.done : TextInputAction.next,
              decoration: const InputDecoration(
                counterText: '',
              ),
              onChanged: (_) {
                if (isLastPosition) {
                  _verifyPin();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildResendComponent() {
    return StatefulBuilder(
      builder: (context, setState) {
        if (_lastOtpRequested.difference(DateTime.now()).isNegative) {
          return TextButtonComponentUi(
            text: const Text('Resend OTP code'),
            onTap: () {
              _lastOtpRequested = DateTime.now().add(_requestFrequency);
              widget.onRequest(context);
              setState(() {});
            },
          );
        }

        return TickerComponent(
          onProcess: () {
            setState(() {});
            return !_lastOtpRequested.difference(DateTime.now()).isNegative;
          },
          onBuild: () {
            final seconds = _lastOtpRequested.difference(DateTime.now()).inSeconds + 1;
            return  TextButtonComponentUi(
              text: Text('Resting... ($seconds sec)'),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
