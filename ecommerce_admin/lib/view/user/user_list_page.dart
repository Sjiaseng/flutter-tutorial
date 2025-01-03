import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/view/user/provider/user_provider.dart';
import 'package:ecommerce_admin/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});
  static const String routeName = '/userlistpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Users'),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          provider.sortUserList();
          return provider.userList.isNotEmpty
              ? ListView.builder(
            itemCount: provider.userList.length,
            itemBuilder: (context, index) {
              final user = provider.userList[index];
              return ListTile(
                title: Text(user.userName),
                subtitle: Text(user.email),
                trailing: Text(
                  "Joined on \n${getFormattedDate(user.creationTime.toDate(), pattern: 'dd MMM yyyy hh:mm a')}",
                ),
              );
            },
          )
              : const Center(child: Text('No users found'));
        },
      ),
    );
  }
}
