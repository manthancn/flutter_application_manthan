import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_manthan/models/customer_model.dart';

import 'package:flutter_application_manthan/screens/dynamic_list/dynamic_item_details_view.dart';

class DynamicItemListView extends StatefulWidget {
  const DynamicItemListView({
    super.key,
  });

  static const routeName = '/dynamic_list';

  @override
  State<DynamicItemListView> createState() {
    return _DynamicItemListViewState();
  }
}

class _DynamicItemListViewState extends State<DynamicItemListView> {
  List? data;
  List<CustomerModel> aryOfCustomerList = [];

  @override
  void initState() {
    super.initState();
    _getList();
  }

  void _getList() async {
    final dio = Dio();
    final response = await dio.get('https://api.slingacademy.com/v1/sample-data/users');


    setState(() {
      data = response.data['users'];
      if (data != null && data is List<dynamic>) {
        aryOfCustomerList = data?.map((e) => CustomerModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No users found!'),
    );

    if (aryOfCustomerList.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: aryOfCustomerList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(aryOfCustomerList[index].strFullName),
            subtitle: Text(aryOfCustomerList[index].strEmail ?? ''),
            leading: CircleAvatar(
              // foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              backgroundImage: NetworkImage(
                  aryOfCustomerList[index].strProfilePic ?? ''
              ),
            ),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                DynamicItemDetailsView.routeName,
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Item List'),
      ),
      body: mainContent,
    );
  }
}
