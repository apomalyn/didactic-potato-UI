// FLUTTER AND THIRD-PARTIES
import 'dart:async';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODELS AND VIEW MODEL
import 'package:UI/core/viewmodels/account_view_model.dart';
import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';

// WIDGETS
import 'package:UI/ui/views/base_widget.dart';
import 'package:UI/ui/widgets/tag_chip.dart';
import 'package:UI/ui/widgets/search_text_field.dart';
import 'package:toast/toast.dart';
import 'package:UI/ui/widgets/account_avatar.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountViewModel>(
        model: AccountViewModel(
            api: Provider.of(context),
            storageService: Provider.of(context),
            user: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: !model.busy,
              ),
              body: SafeArea(
                child: model.busy
                    ? Center(child: CircularProgressIndicator())
                    : Row(children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(100.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Hello ${model.user.firstname}!',
                                    style: TextStyle(fontSize: 70)),
                                SizedBox(height: 50.0),
                                _buildJobType(model),
                                SizedBox(height: 30.0),
                                _buildTags(model),
                                SizedBox(height: 30.0),
                                RaisedButton(
                                  child: Text('Upload your picture'),
                                  onPressed: () async {
                                    File file = await getFile();
                                    try {
                                      model.uploadToFirebase(file);
                                    } catch (e) {
                                      Toast.show(
                                          "Something wrong happened...please try later",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER);
                                      print(e);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(100.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Your CV",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 30)),
                                SizedBox(height: 15.0),
                                (model.user as Student).cv != null
                                    ? Container()
                                    : Container(
                                        child: Text(
                                            "You didn't upload your CV..."),
                                      ),
                                SizedBox(height: 15.0),
                                RaisedButton(
                                  child: Text('Upload your picture'),
                                  onPressed: () async {
                                    File file = await getFile(isImage: false);
                                    try {
                                      model.uploadToFirebase(file);
                                    } catch (e) {
                                      print(e);
                                      Toast.show(
                                          "Something wrong happened...please try later",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
              ),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {}, label: Text('Save')),
            ));
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
                SearchTextField(
                    onTap: (Tag value) => model.handleAddTag(value)),
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

  /// Open dialog to choose a file from the PC of the user than upload the file selected
  Future<File> getFile({bool isImage = true}) {
    final completer = new Completer<File>();
    final InputElement input = document.createElement('input');
    input
      ..type = 'file'
      ..accept = isImage ? 'image/*' : 'application/pdf';
    input.onChange.listen((e) async {
      final List<File> files = input.files;
      final reader = new FileReader();
      reader.readAsDataUrl(files[0]);
      reader.onError.listen((error) => completer.completeError(error));
      await reader.onLoad.first;
      completer.complete(files[0]);
    });
    input.click();
    return completer.future;
  }
}
