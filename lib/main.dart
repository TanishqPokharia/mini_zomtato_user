import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_zomato_user/presentation/bloc/address/address_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/auth/auth_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/menu/menu_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/orders/orders_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/restaurant/restaurant_list_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/splash_screen.dart';
import 'package:mini_zomato_user/utils/dependencies.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  registerDependencies(getIt);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<RestaurantListBloc>()),
        BlocProvider(create: (_) => getIt<CartBloc>()),
        BlocProvider(create: (_) => getIt<OrdersBloc>()),
        BlocProvider(create: (_) => getIt<AddressBloc>()),
        BlocProvider(create: (_) => getIt<MenuBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Zomato',
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          cardTheme: CardTheme(color: Colors.white),
          snackBarTheme: SnackBarThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            contentTextStyle: GoogleFonts.jost(color: Colors.black),
            closeIconColor: Colors.black,
            actionTextColor: Colors.redAccent,
          ),
          textTheme: GoogleFonts.jostTextTheme(ThemeData.light().textTheme),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
