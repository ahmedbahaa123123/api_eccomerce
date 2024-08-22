import 'package:api_eccomerce/core/widget/custom_default_Button.dart';
import 'package:api_eccomerce/core/widget/custom_text_field.dart';
import 'package:api_eccomerce/screens/auth/logic/auth_cubit.dart';
import 'package:api_eccomerce/screens/auth/logic/auth_states.dart';
import 'package:api_eccomerce/screens/auth/views/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  label: "email",
                  icon: const Icon(Icons.email),
                  controller: cubit.emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: "Password",
                  icon: const Icon(Icons.lock),
                  controller: cubit.passwordController,
                ),
                const SizedBox(height: 20),
                (state is AuthLoading)
                    ? const CircularProgressIndicator()
                    : CustomDefaultButton(
                        text: "LOGIN",
                        onPressed: () {
                          cubit.login(context);
                        }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("don't have Account"),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state is AuthSuccess)
                  const Text(
                    "congrats",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
