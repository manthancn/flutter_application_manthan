import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_manthan/models/user.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key, required this.onAddUser});

  final void Function(User user) onAddUser;

  @override
  State<NewUser> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewUser> {
  final _titleController = TextEditingController();
  final _ageController = TextEditingController();

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure a valid title, age was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ));
    } else {
      // show an error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure a valid title, age was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  void _submitUserData() {
    final enteredAge = int.tryParse(_ageController
        .text); // retParse('Hello) => null, tryParse('1.12') => 1.12
    final ageIsInvalid = enteredAge == null || enteredAge <= 0;
    if (_titleController.text.trim().isEmpty || ageIsInvalid) {
      _showDialog();
      return;
    }

    widget.onAddUser(User(
      title: _titleController.text,
      age: enteredAge,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double
            .infinity, // make full height after keyboard overlap issue in form
        child: SingleChildScrollView(
          child: Padding(
            // padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Age'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitUserData();
                        print(_titleController.text);
                        print(_ageController.text);
                      },
                      child: const Text('Add User'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
