import 'package:api_eccomerce/core/widget/custom_default_Button.dart';
import 'package:api_eccomerce/core/widget/custom_text_field.dart';
import 'package:api_eccomerce/screens/auth/logic/auth_cubit.dart';
import 'package:api_eccomerce/screens/auth/logic/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AuthCubit, AuthStates>(
              builder: (context, state) {
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
                      label: "phone",
                       icon:  const Icon(Icons.phone),
                        controller: cubit.phoneController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "name",
                       icon: const Icon(Icons.person),
                        controller: cubit.nameController,
                    ),
                    const SizedBox(height:20 ,),
                    (state is AuthLoading)?
                    const CircularProgressIndicator():
                   Center(
                      child: CustomTextField(
                        label: "password",
                         icon:const Icon(Icons.lock),
                          controller: cubit.passwordController,
                      ),
                    ),
                     const SizedBox(height:20 ,),
                    CustomDefaultButton(
                          text: "SIGNUP",
                           onPressed: (){
                            cubit.register(context);
                           }),
                  ],
                );
              }
            ),
          ),
        ),
    );
  }
}