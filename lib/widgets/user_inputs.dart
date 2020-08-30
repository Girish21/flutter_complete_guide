import 'package:flutter/material.dart';

class UserInputs extends StatefulWidget {
  final Function addTransaction;

  UserInputs({@required this.addTransaction});

  @override
  _UserInputsState createState() => _UserInputsState();
}

class _UserInputsState extends State<UserInputs> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _titleFocusNode = FocusNode();

  final _amountFocusNode = FocusNode();

  void submit() {
    final title = _titleController.text;
    final amount = _amountController.text;

    if (title.isEmpty || double.parse(amount) < 0) return;

    widget.addTransaction(
      title: title,
      amount: amount,
    );

    Navigator.of(context).pop();
  }

  void _getFocusNode(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
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
                onSubmitted: (_) => submit(),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: submit,
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
