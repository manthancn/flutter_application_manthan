import 'package:flutter/material.dart';

import 'package:flutter_application_manthan/screens/dynamic_list/dynamic_item_list_view.dart';
import 'package:flutter_application_manthan/screens/static_list/static_item_list_view.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/flutter_logo.png'),
              ),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('List View'),
            onTap: () => {
              Navigator.restorablePushNamed(
                context,
                SampleItemListView.routeName,
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Custom View'),
            onTap: () => {
              Navigator.restorablePushNamed(
                context,
                DynamicItemListView.routeName,
              ),
            },
          ),
        ],
      ),
    );
  }
}
