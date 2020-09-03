import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInputs extends StatefulWidget {
  final Function addTransaction;

  UserInputs({@required this.addTransaction});

  @override
  _UserInputsState createState() => _UserInputsState();
}

class _UserInputsState extends State<UserInputs> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime chosenDate;

  final _titleFocusNode = FocusNode();

  final _amountFocusNode = FocusNode();

  void _submit() {
    final title = _titleController.text;
    final amount = _amountController.text;

    if (title.isEmpty || double.parse(amount) < 0 || chosenDate == null) return;

    widget.addTransaction(
      title: title,
      amount: amount,
      date: chosenDate,
    );

    Navigator.of(context).pop();
  }

  void _getFocusNode(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  void _showDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );

    setState(() {
      chosenDate = date;
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                focusNode: _titleFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => _getFocusNode(
                  context,
                  _titleFocusNode,
                  _amountFocusNode,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                focusNode: _amountFocusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                ),
                child: Row(
                  children: [
                    if (chosenDate == null) Text('No Date Chosen!'),
                    if (chosenDate != null)
                      Text(
                        'Chosen date ${DateFormat.yMMMd().format(chosenDate)}',
                      ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                      child: Text('Chose Date'),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                  onPressed: _submit,
                  child: Text(
                    'Add Transaction',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
