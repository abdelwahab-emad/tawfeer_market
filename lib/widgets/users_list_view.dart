import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/users_cubit/users_cubit.dart';
import 'package:tawfeer_market/widgets/user_list_item.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(kprimarycolor)),
          );
        }

        if (state is UserError) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is UserSuccess) {
          if (state.usersList.isEmpty) {
            return const Center(child: Text("No Users yet"));
          }
          final users = state.usersList;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserListItem(
                name: '${user.firstName} ${user.lastName}',
                email: user.email,
                createdAt: user.createdAt.toLocal().toString().split(' ')[0],
                status: user.status,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
