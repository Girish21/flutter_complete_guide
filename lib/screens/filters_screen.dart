import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const FiltersRoute = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  const Filters({
    Key key,
    this.saveFilters,
    this.filters,
  }) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _glutenFree = false;
  var _vegitarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.filters['glutten'];
    _vegitarian = widget.filters['vegitarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
  }

  Widget _buildSwitchTile({
    @required Widget title,
    @required bool value,
    @required Function changeHadler,
  }) {
    return SwitchListTile(
      title: title,
      value: value,
      onChanged: changeHadler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () => widget.saveFilters(
              {
                'glutten': _glutenFree,
                'vegitarian': _vegitarian,
                'vegan': _vegan,
                'lactose': _lactoseFree,
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(
              24,
            ),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  title: Text('Glutten Free'),
                  value: _glutenFree,
                  changeHadler: (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: Text('Vegitarian'),
                  value: _vegitarian,
                  changeHadler: (val) {
                    setState(() {
                      _vegitarian = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: Text('Vegan'),
                  value: _vegan,
                  changeHadler: (val) {
                    setState(() {
                      _vegan = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: Text('Lactose Free'),
                  value: _lactoseFree,
                  changeHadler: (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
