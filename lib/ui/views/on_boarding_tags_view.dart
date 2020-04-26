import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingTagsView extends StatefulWidget {

  @override
  _OnBoardingTagsViewState createState() => _OnBoardingTagsViewState();
}

class _OnBoardingTagsViewState extends State<OnBoardingTagsView> {
  List<String> _selectedTags = [];

  @override
  void initState() {
    _selectedTags = [];
    super.initState();
  }

  @override
  void dispose() {
    _selectedTags.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);
    return Center(
      child: Card(
        child: Container(
          width: 800,
          height: 400,
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48.0, top: 32.0),
                    child: Text(
                      _user != null && _user is Student ? "What do you like?" : "What are you looking for?",
                      style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}