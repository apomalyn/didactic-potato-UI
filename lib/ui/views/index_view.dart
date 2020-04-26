// FLUTTER AND THIRD-PARTIES
import 'package:UI/core/constants/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// SERVICES
import 'package:UI/core/services/user_repository.dart';

class IndexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _checkIfSignedIn(Provider.of<UserRepository>(context), context);

    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Stop running for job postings!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: 400.0,
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "By leaving the choice to the students for the job they want, employers get the chance to obtain the expertise they want and students to land their dream job.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: MaterialButton(
                      height: 64.0,
                      onPressed: () => Navigator.pushNamed(context, RouterPaths.SIGN_IN),
                      color: Color(0xFF2a9d8f),
                      child: Text(
                        "Getting Started!",
                        style: TextStyle(color: Colors.white, fontSize: 28.0),
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkIfSignedIn(UserRepository userRepository, BuildContext context) async {
    if(await userRepository.isSignedIn()) {
      Navigator.pushReplacementNamed(context, RouterPaths.HOME);
    }
  }
}