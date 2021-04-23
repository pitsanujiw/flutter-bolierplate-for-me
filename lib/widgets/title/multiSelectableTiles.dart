import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';


class SelectableItem {
  String name;
  String value;

  SelectableItem(this.name, this.value);

  SelectableItem.fromJson(Map<String, String> json) {
    this.name = json["name"];
    this.value = json["value"];
  }

  Map<String, String> toJson() {
    return {
      "name": this.name,
      "value": this.value,
    };
  }
}

class MultiSelectableTiles extends StatefulWidget {
  final SelectableType type;
  final List<SelectableItem> items;
  final List<String> selectedItems;
  final Function(List<String>) onChanged;

  const MultiSelectableTiles({
    Key key,
    this.type = SelectableType.checkbox,
    @required this.items,
    @required this.selectedItems,
    @required this.onChanged,
  }) : super(key: key);

  @override
  MultiSelectableTilesState createState() => MultiSelectableTilesState();
}

class MultiSelectableTilesState extends State<MultiSelectableTiles> {
  List<SelectableItem> _ownItems = [];
  List<String> _ownSelectedItems = [];

  @override
  void initState() {
    _ownItems = List.from(this.widget.items);
    _ownSelectedItems = List.from(this.widget.selectedItems);
    super.initState();
  }

  void _handleOnchanged(String item) {
    this.setState(() {
      if (this.widget.type == SelectableType.checkbox) {
        if (_ownSelectedItems.contains(item)) {
          _ownSelectedItems.remove(item);

          if (_ownSelectedItems?.isEmpty ?? true) {
            _ownSelectedItems = [];
          }
        } else {
          _ownSelectedItems.add(item);
        }
      } else {
        _ownSelectedItems = [item];
      }
    });

    this.widget.onChanged(_ownSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _ownItems?.length ?? 0,
      itemBuilder: (context, index) {
        return SelectableTile.right(
          type: this.widget.type,
          text: _ownItems[index].name,
          isSelected: _ownSelectedItems.contains(
            _ownItems[index].value,
          ),
          onChanged: () => _handleOnchanged(
            _ownItems[index].value,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Line();
      },
    );
  }
}
