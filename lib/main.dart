import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';
import 'package:ecommerce_dummy/bloc/product_list/product_list_bloc.dart';
import 'package:ecommerce_dummy/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:ecommerce_dummy/presentation/view/product_list_view.dart';
import 'package:ecommerce_dummy/repositories/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductListBloc()..add(FetchProducts()),
        ),
        BlocProvider(
          create: (context) => ShoppingCartBloc(),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce Dummy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductListView(),
      ),
    );
  }
}
