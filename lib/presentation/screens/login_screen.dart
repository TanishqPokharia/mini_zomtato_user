import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/auth/auth_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/home_screen.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to Mini Zomato',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: context.rs(20)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.rs(40),
                      vertical: context.rs(20),
                    ),
                    child: TextFormField(
                      onSaved: (value) {
                        email = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.rs(40),
                      vertical: context.rs(20),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      onSaved: (value) {
                        password = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(20)),
                  if (state is AuthLoading)
                    Container(
                      width: context.screenWidth / 2,
                      height: context.rs(60),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: context.rs(30),
                          width: context.rs(30),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      width: context.screenWidth / 2,
                      height: context.rs(60),
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<AuthBloc>().add(
                              AuthLoginEvent(email: email, password: password),
                            );
                          }
                        },
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: context.textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
