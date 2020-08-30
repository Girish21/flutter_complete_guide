import 'package:flutter/material.dart';

class UserInputs extends StatelessWidget {
  final Function addTransaction;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  final _titleFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  UserInputs({@required this.addTransaction});

  void submit() {
    addTransaction(
      title: _titleController.text,
      amount: _amountController.text,
    );
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
                  onPressed: () => submit(),
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
