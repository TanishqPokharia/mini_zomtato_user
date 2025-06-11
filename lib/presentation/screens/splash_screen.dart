import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/auth/auth_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/home_screen.dart';
import 'package:mini_zomato_user/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthBloc>().add(AuthCheckEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Mini Zomato',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
