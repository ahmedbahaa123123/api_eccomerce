import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(child: Text('Failed to load profile: ${state.message}'));
              } else if (state is HomeSuccess) {
                var cubit = HomeCubit.get(context);
                final profile = cubit.profile;
                return profile != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        profile.image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return Image.network(
                                        "https://hacked.com/wp-content/uploads/2020/12/hacking.jpg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profile.name,
                                            style: Theme.of(context).textTheme.headlineSmall,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            profile.email,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Phone: ${profile.phone}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Card(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   elevation: 5,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(16.0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           'Additional Information',
                            //           style: Theme.of(context).textTheme.headlineSmall,
                            //         ),
                            //         const SizedBox(height: 10),
                            //         Text(
                            //           'Some additional information about the user can go here.',
                            //           style: Theme.of(context).textTheme.bodyMedium,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    : const Center(child: Text('Profile data is not available'));
              } else {
                return const Center(child: Text('Unexpected State'));
              }
            },
          ),
        ),
      ),
    );
  }
}
