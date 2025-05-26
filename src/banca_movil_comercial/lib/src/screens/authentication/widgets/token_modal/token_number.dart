import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TokenNumber extends StatefulWidget {
  final String tokenNumber;
  final VoidCallback onNext;

  /// Remember to set this dinamically, assuming BE provides it
  /// Token remaining time in seconds
  final int tokenRemainingTime;

  const TokenNumber({
    required this.tokenNumber,
    required this.onNext,
    this.tokenRemainingTime = 25,
    super.key,
  });

  @override
  State<TokenNumber> createState() => _TokenNumberState();
}

class _TokenNumberState extends State<TokenNumber> {
  String splitInHalfWithSpace(String input) {
    final mid = (input.length / 2).ceil();
    final firstHalf = input.substring(0, mid);
    final secondHalf = input.substring(mid);
    return '$firstHalf $secondHalf';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Modal Title
        Text(
          context.lang.tokenNumber,
          style: TextStyle(
            fontSize: 16.w(context),
            fontWeight: FontWeight.w700,
            color: color07355E,
          ),
        ),
        SizedBox(height: 24.h(context)),

        // Token Section
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
          child: Stack(
            children: [
              _TokenTimeIndicator(initialSeconds: widget.tokenRemainingTime),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h(context),
                  horizontal: 20.w(context),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          splitInHalfWithSpace(widget.tokenNumber),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26.w(context).clamp(18.0, 28.0),
                            fontWeight: FontWeight.w900,
                            color: color07355E,
                            letterSpacing: 7.0,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Clipboard.setData(
                          ClipboardData(text: widget.tokenNumber),
                        );
                      },
                      child: Icon(
                        Icons.copy_outlined,
                        size: 24.w(context),
                        color: color1C274C,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h(context)),

        // New token button
        TextButton(
          // TODO: Implement generate token functionality
          onPressed: () {},
          child: Text(
            context.lang.generateNewToken,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeight.w500,
              color: color0080F2,
            ),
          ),
        ),
        SizedBox(height: 10.h(context)),

        // More options tile
        Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(color: color07355E26, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: widget.onNext,
            dense: true,
            minVerticalPadding: 8.h(context),
            contentPadding: EdgeInsets.only(
              left: 25.w(context),
              right: 12.w(context),
            ),
            title: Text(
              context.lang.moreOptions,
              style: TextStyle(
                color: color506578,
                fontSize: 14.w(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.w(context),
              color: color1C274C,
            ),
          ),
        ),
        SizedBox(height: 20.h(context)),

        // Disclaimer
        Padding(
          padding: EdgeInsets.only(top: 12.h(context), bottom: 20.h(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 18.w(context),
                color: color1C274C.withOpacity(0.4),
              ),
              SizedBox(width: 8.w(context)),
              Expanded(
                child: Text(
                  context.lang.tokenNotice,
                  style: TextStyle(fontSize: 12.w(context), color: color506578),
                ),
              ),
            ],
          ),
        ),

        // Final divider
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Divider(color: color07355E.withOpacity(.12), thickness: 1),
        ),
      ],
    );
  }
}

class _TokenTimeIndicator extends StatefulWidget {
  final int initialSeconds;

  const _TokenTimeIndicator({required this.initialSeconds});
  @override
  State<_TokenTimeIndicator> createState() => _TokenTimeIndicatorState();
}

class _TokenTimeIndicatorState extends State<_TokenTimeIndicator>
    with SingleTickerProviderStateMixin {
  static const int _totalSeconds = 60;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    double startValue = 1.0 - (widget.initialSeconds / _totalSeconds);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0); // reinicia automáticamente
      }
    });

    _controller.forward(from: startValue); // ⬅️ Arranca desde tu valor
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = 1.0 - _controller.value;
        return LinearProgressIndicator(
          value: progress,
          borderRadius: BorderRadius.circular(7),
          minHeight: 65.h(context),
          backgroundColor: const Color(0xFFF6F9FC),
          valueColor: AlwaysStoppedAnimation<Color>(
            color005199.withOpacity(.12),
          ),
        );
      },
    );
  }
}
