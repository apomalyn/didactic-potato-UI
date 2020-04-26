import 'package:UI/core/constants/constants.dart';
import 'package:UI/core/models/tag.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final Function onTap;

  const SearchTextField({Key key, this.onTap}) : super(key: key);

  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = new TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  bool _isUp = false;

  List<Tag> _filteredTags = Constants.tags;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          labelText: 'Add a new skill',
          labelStyle: TextStyle(color: Colors.black54)),
      onChanged: (query) {
        setState(() {
          if (_controller.text.length > 0) {
            _filterList(query);
            if (_isUp) _overlayEntry.remove();
            _overlayEntry = _buildOverlay();
            Overlay.of(context).insert(_overlayEntry);
            _isUp = true;
          } else if (_isUp) {
            _overlayEntry.remove();
            _isUp = false;
          }
        });
      },
      controller: _controller,
    );
  }

  OverlayEntry _buildOverlay() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: _buildSuggestions()),
        ),
      ),
    );
  }

  List<Widget> _buildSuggestions() {
    List<Widget> tiles = [];

    for (int i = 0; i < 4 && i < _filteredTags.length; i++) {
      tiles.add(ListTile(
        title: Text(_filteredTags[i].name),
        trailing: Icon(Icons.add_circle, color: Colors.black54),
        onTap: () {
          widget.onTap(_filteredTags[i]);
          _isUp = false;
          _overlayEntry.remove();
          _controller.text = "";
        },
      ));
    }

    return tiles;
  }

  void _filterList(String query) {
    _filteredTags = Constants.tags
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
