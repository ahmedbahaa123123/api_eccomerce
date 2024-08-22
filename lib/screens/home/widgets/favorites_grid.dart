// import 'package:eccomerce/screens/home/logic/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeGridView extends StatelessWidget {
//   const HomeGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         var cubit = HomeCubit.get(context);

//         return (state is HomeLoading)?
//         const Center(child:  CircularProgressIndicator()):
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1/1.4,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//           ),
//           itemCount: cubit.favorites.length,
//           itemBuilder: (context, index) {
//             return Container(
//               padding: const EdgeInsets.all(10),
//               color: Colors.grey.shade100,
//               child: Expanded(
//                 child: Column(
//                   children: [
//                     Image.network(cubit.favorites[index].image,
//                     height: 100,
//                     width: 200,
//                     fit: BoxFit.cover,
//                     ),
//                      Text(cubit.favorites[index].name),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesGrid extends StatelessWidget {
  const FavoritesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return (state is HomeLoading)
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: cubit.favorites.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Image.network(
                          cubit.favorites[index].image,
                          height: 100,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          cubit.favorites[index].name,
                          maxLines: 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${cubit.favorites[index].price.toString()}',
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
