import 'package:flutter/material.dart';
import 'package:flutter_application_manthan/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_manthan/models/user.dart';
import 'package:flutter_application_manthan/widgets/nav_drawer.dart';
import 'package:flutter_application_manthan/widgets/new_user.dart';
import 'package:flutter_application_manthan/data/dummy_data.dart';
import 'static_item_details_view.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() {
    return _SampleItemListViewState();
  }
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final Box box = Hive.box('users'); // Get the box
  List<User> _registeredUsers = availableUsers;

  void _openAddUserOverlay() {
    showModalBottomSheet(
      useSafeArea: true, // notch display setting
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewUser(onAddUser: _addUser),
    );
  }

  void _addUser(User user) {
    setState(() {
      _registeredUsers.add(user);
      box.put('users', _registeredUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No users found. Start adding some!'),
    );
    box.put('users', _registeredUsers);

    if (_registeredUsers.isNotEmpty) {
      _registeredUsers = box.get('users');
      print(_registeredUsers);
      mainContent = ListView.builder(
        itemCount: _registeredUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _registeredUsers[index];
          return Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.55),
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListTile(
              title: Text(
                item.title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              // subtitle: Text(item.age as String),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: mainContent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.onBackground,
          onPressed: () {
            _openAddUserOverlay();
          },
          child: const Icon(Icons.add),
        ));
  }
}
