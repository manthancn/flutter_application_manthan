import 'package:flutter/material.dart';
import 'package:flutter_application_manthan/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_manthan/models/user.dart';
import 'package:flutter_application_manthan/widgets/nav_drawer.dart';
import 'package:flutter_application_manthan/widgets/new_user.dart';
import 'package:flutter_application_manthan/data/dummy_data.dart';
import 'static_item_details_view.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final Box<UserModel> box = Hive.box<UserModel>('users');

  // Combine Hive users and dummy users
  List<UserModel> get combinedUsers {
    return [
      ...availableUsers.map((user) => UserModel(user.id, user.title, user.age)),
      ...box.values,
    ];
  }

  void _openAddUserOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewUser(onAddUser: _addUser),
    );
  }

  void _addUser(User user) {
    final userModel = UserModel(user.id, user.title, user.age);

    setState(() {
      box.add(userModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: combinedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final user = combinedUsers[index];

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
                user.title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        onPressed: _openAddUserOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
