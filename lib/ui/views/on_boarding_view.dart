import 'package:UI/ui/widgets/account_register_widget.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AccountRegisterForm(),
      ),
    );
  }
}