import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

import 'token_more_options.dart';
import 'token_number.dart';

class TokenModal extends StatefulWidget {
  const TokenModal({super.key});

  @override
  State<TokenModal> createState() => _TokenModalState();
}

/// TODO: Implement get user Token info functionality.
/// Remember to get somehow the token remaining time, assuming BE provides it.
/// Don't forget about serial token number too, assuming BE provides it, add it
/// as a property in this returned TokenModel for simplicity.
Future<TokenModel> getTokenInfo() async {
  await Future.delayed(const Duration(milliseconds: 300));
  return TokenModel(
    expiration: '31/12/2025',
    token: '25486147',
    refreshToken: '',
    isSessionActive: true,
  );
}

class _TokenModalState extends State<TokenModal> {
  late Future<TokenModel> _tokenFuture;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tokenFuture = getTokenInfo();
    _pageController = PageController();
  }

  void _nextPage() => _pageController.nextPage(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );

  void _prevPage() => _pageController.previousPage(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TokenModel>(
      future: _tokenFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 300.h(context),
            child: const Center(
              child: CircularProgressIndicator(color: color0080F2),
            ),
          );
        }

        final tokenInfo = snapshot.data!;

        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TokenNumber(
              onNext: _nextPage,
              tokenNumber: tokenInfo.token,
              // TODO: Set this dynamically
              tokenRemainingTime: 25,
            ),
            TokenMoreOptions(
              onBack: _prevPage,
              expirationDate: tokenInfo.expiration,
              // TODO: Add dynamic serial token number
              serial: '1234567890001',
            ),
          ],
        );
      },
    );
  }
}
