import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is NetworkFailure) {
                return Text(
                  "No Internet Connection",
                  style: TextStyle(color: Colors.red.shade500),
                );
              } else if (state is NetworkSuccess) {
                return Text(
                  "You're Connected to Internet",
                  style: TextStyle(color: Colors.green.shade500),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
