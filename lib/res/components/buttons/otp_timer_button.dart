import 'dart:async';

import 'package:flutter/material.dart';

enum ButtonState { enableButton, loading, timer }

enum ButtonType { elevatedButton, textButton, outlinedButton }

class OtpTimerButton extends StatefulWidget {
  final VoidCallback? onPressed;

  final Text text;
  final ProgressIndicator? loadingIndicator;
  final int duration;
  final OtpTimerButtonController? controller;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingIndicatorColor;
  final ButtonType buttonType;
  final double? radius;

  const OtpTimerButton(
      {super.key,
        required this.onPressed,
        required this.text,
        this.loadingIndicator,
        required this.duration,
        this.controller,
        this.height,
        this.backgroundColor,
        this.textColor,
        this.loadingIndicatorColor,
        this.buttonType = ButtonType.elevatedButton,
        this.radius});

  @override
  State<OtpTimerButton> createState() => _OtpTimerButtonState();
}

class _OtpTimerButtonState extends State<OtpTimerButton> {
  Timer? _timer;
  int _counter = 0;
  ButtonState _state = ButtonState.timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    widget.controller?._addListeners(_startTimer, _loading, _enableButton);
  }

  _startTimer() {
    _timer?.cancel();
    _state = ButtonState.timer;
    _counter = widget.duration;

    setState(() {});

    _timer = Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) {
        if (_counter == 0) {
          _state = ButtonState.enableButton;
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _counter--;
          });
        }
      },
    );
  }

  _loading() {
    _state = ButtonState.loading;
    setState(() {});
  }

  _enableButton() {
    _state = ButtonState.enableButton;
    setState(() {});
  }

  _childBuilder() {
    switch (_state) {
      case ButtonState.enableButton:
        return widget.text;
      case ButtonState.loading:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.text,
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: widget.loadingIndicator ??
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: widget.loadingIndicatorColor,
                  ),
            ),
          ],
        );
      case ButtonState.timer:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.text,
            SizedBox(
              width: 10,
            ),
            Text(
              '$_counter',
              style: widget.text.style,
            ),
          ],
        );
    }
  }

  _roundedRectangleBorder() {
    if (widget.radius != null) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius!),
      );
    } else {
      return null;
    }
  }

  _onPressedButton() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    if (widget.controller == null) {
      _startTimer();
    }
  }

  _buildButton() {
    switch (widget.buttonType) {
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed:
          _state == ButtonState.enableButton ? _onPressedButton : null,
          child: _childBuilder(),
          style: ElevatedButton.styleFrom(
            foregroundColor: widget.textColor,
            backgroundColor: widget.backgroundColor,
            shape: _roundedRectangleBorder(),
          ),
        );
      case ButtonType.textButton:
        return TextButton(
          onPressed:
          _state == ButtonState.enableButton ? _onPressedButton : null,
          child: _childBuilder(),
          style: TextButton.styleFrom(
            foregroundColor: widget.backgroundColor,
            shape: _roundedRectangleBorder(),
          ),
        );
      case ButtonType.outlinedButton:
        return OutlinedButton(
          onPressed:
          _state == ButtonState.enableButton ? _onPressedButton : null,
          child: _childBuilder(),
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.backgroundColor,
            shape: _roundedRectangleBorder(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: _buildButton(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class OtpTimerButtonController {
  late VoidCallback _startTimerListener;
  late VoidCallback _loadingListener;
  late VoidCallback _enableButtonListener;

  _addListeners(startTimerListener, loadingListener, enableButtonListener) {
    _startTimerListener = startTimerListener;
    _loadingListener = loadingListener;
    _enableButtonListener = enableButtonListener;
  }

  startTimer() {
    _startTimerListener();
  }

  loading() {
    _loadingListener();
  }

  enableButton() {
    _enableButtonListener();
  }
}
