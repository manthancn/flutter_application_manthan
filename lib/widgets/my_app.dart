import 'package:flutter/material.dart';

import 'package:flutter_application_manthan/screens/dynamic_list/dynamic_item_details_view.dart';
import 'package:flutter_application_manthan/screens/dynamic_list/dynamic_item_list_view.dart';

import '../screens/static_list/static_item_details_view.dart';
import '../screens/static_list/static_item_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SampleItemDetailsView.routeName:
                return const SampleItemDetailsView();
              case DynamicItemListView.routeName:
                return const DynamicItemListView();
              case DynamicItemDetailsView.routeName:
                return const DynamicItemDetailsView();
              default:
                return const SampleItemListView();
            }
          },
        );
      },
    );
  }
}
