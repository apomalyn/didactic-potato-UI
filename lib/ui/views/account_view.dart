// FLUTTER AND THIRD-PARTIES
import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';
import 'package:UI/core/viewmodels/account_view_model.dart';
import 'package:UI/ui/views/base_widget.dart';
import 'package:UI/ui/widgets/search_text_field.dart';
import 'package:UI/ui/widgets/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountViewModel>(
      model: AccountViewModel(
          api: Provider.of(context), user: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Hello ${model.user.firstname}!',
                              style: TextStyle(fontSize: 70)),
                          SizedBox(height: 50.0),
                          _buildJobType(model),
                          SizedBox(height: 30.0),
                          _buildTags(model)
                        ],
                      ),
                    ),
                  ),
                ]),
          )),
    );
  }

  /// Build and handle type of jobs
  Widget _buildJobType(AccountViewModel model) {
    var chips = [];
    JobType.values.forEach((element) {
      chips.add(FilterChip(
        label: Text(element.toString().split('.').last),
        selected: element == (model.user as Student).searchingFor,
        onSelected: (_) => model.handleSearchingForChange(element),
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("You are looking for ",
            textAlign: TextAlign.left, style: TextStyle(fontSize: 30)),
        Wrap(
          children: <Widget>[
            for (final chip in chips)
              Padding(
                child: chip,
                padding: const EdgeInsets.all(4),
              )
          ],
        ),
      ],
    );
  }

  /// Build and handle the skills of the student
  Widget _buildTags(AccountViewModel model) {
    var chips = [];
    model.getTags().forEach((element) {
      chips.add(TagChip(
          tag: element, onDeleted: () => model.handleDeletionTag(element)));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Your skills",
            textAlign: TextAlign.left, style: TextStyle(fontSize: 30)),
        SizedBox(height: 20.0),
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
    );
  }
}
