import 'package:UI/core/constants/router_paths.dart';
import 'package:UI/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:UI/ui/utils/theme.dart' as AppColor;

class OnBoardingUserTypeView extends StatefulWidget {
  @override
  _OnBoardingUserTypeViewState createState() => _OnBoardingUserTypeViewState();
}

class _OnBoardingUserTypeViewState extends State<OnBoardingUserTypeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Card(
            child: Container(
              width: 800,
              height: 400,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 48.0, top: 32.0, bottom: 64.0),
                        child: Text(
                          "Are you?",
                          style: TextStyle(
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                          height: 56.0,
                          color: AppColor.persian,
                          onPressed: () {
                            Navigator.pushNamed(context, RouterPaths.ON_BOARDING_ACCOUNT, arguments: UserType.Student);
                          },
                          child: Text(
                            "A Student",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                          height: 56.0,
                          color: AppColor.persian,
                          onPressed: () {
                            Navigator.pushNamed(context, RouterPaths.ON_BOARDING_ACCOUNT, arguments: UserType.Employer);
                          },
                          child: Text(
                            "An employer",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
