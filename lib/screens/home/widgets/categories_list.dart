import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:api_eccomerce/screens/home/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return const Center(child: Text('SOON'));
        } else if (state is HomeSuccess) {
          var cubit = HomeCubit.get(context);
          return SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = cubit.categories[index];
                return InkWell(
                  onTap: () {
                    if (category.id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(id: category.id!),
                        ),
                      );
                    } else {
                      // Handle the case where id is null
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Category ID is null')),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: category.image != null
                            ? NetworkImage(category.image!)
                            : const NetworkImage('https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive.jpg'),
                        radius: 40,
                      ),
                      Text(
                        category.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemCount: cubit.categories.length,
            ),
          );
        } else {
          return const Center(child: Text('Unexpected State'));
        }
      },
    );
  }
}
