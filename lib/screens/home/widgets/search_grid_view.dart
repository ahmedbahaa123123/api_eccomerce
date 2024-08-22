import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text('Failed to load products: ${state.message}'));
        } else if (state is HomeSuccess) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: cubit.search.length,
                itemBuilder: (context, index) {
                  var product = cubit.search[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Image.network(
                          product.image,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.name,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          maxLines:2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return const Center(child: Text('Unexpected State'));
        }
      },
    );
  }
}
