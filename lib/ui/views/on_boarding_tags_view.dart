import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';
import 'package:UI/core/models/user.dart';
import 'package:UI/core/viewmodels/on_boarding_tags_view_model.dart';
import 'package:UI/ui/views/base_widget.dart';
import 'package:UI/ui/widgets/search_text_field.dart';
import 'package:UI/ui/widgets/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UI/ui/utils/theme.dart' as AppColor;

class OnBoardingTagsView extends StatefulWidget {

  UserType _userType;

  OnBoardingTagsView(UserType type) {
    _userType = type;
  }

  @override
  _OnBoardingTagsViewState createState() => _OnBoardingTagsViewState(_userType);
}

class _OnBoardingTagsViewState extends State<OnBoardingTagsView> {
  var chips = [];

  UserType _userType;

  _OnBoardingTagsViewState(UserType type) {
    _userType = type;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OnBoardingTagsViewModel>(
      model: OnBoardingTagsViewModel(
          user: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
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
                            model.user != null && model.user is Student ? "What do you like?" : "What are you looking for?",
                            style: TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 15.0),
                    _buildTags(model),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 52.0, right: 16.0),
                        child: MaterialButton(
                          onPressed: () {
                            if (chips.isEmpty) {
                              // We need to define at least one tag
                            } else {
                              // Save info to DB
                            }
                          },
                          color: AppColor.persian,
                          child: Text(
                            "Finish",
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
      ),
    );
  }

  /// Build and handle the skills of the student
  Widget _buildTags(OnBoardingTagsViewModel model) {
    var chips = [];
    model.getTags().forEach((element) {
      chips.add(TagChip(
          tag: element, onDeleted: () => model.handleDeletionTag(element)));
    });

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 400.0,
                child: Wrap(
                  children: <Widget>[
                    SearchTextField(onTap: (Tag value) => model.handleAddTag(value)),
                    for (final chip in chips)
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: chip,
                      )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}