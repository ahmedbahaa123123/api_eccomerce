import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:api_eccomerce/screens/home/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return const Center(child: Text('Failed to load products'));
              } else if (state is HomeSuccess) {
                var cubit = HomeCubit.get(context);
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final product = cubit.products[index];
                   // final details = cubit.details;
                    return InkWell(
                      onTap: () {
                        if (product.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(id: product.id),
                            ),
                          );
                        } else {
                          // Handle the case where id is null
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product ID is null')),
                          );
                        }
                      },
                      child: Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              product.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name),
                                  Text('\$${product.price}'),
                                  Row(
                                    children: [
                                      
                                           IconButton(
                                              onPressed: () {
                                                cubit.addFavourites(
                                                  context,
                                                  product.id,
                                                  id,
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.favorite_outline),
                                            ),
                                          //  IconButton(
                                          //     onPressed: () {
                                          //       cubit.addCarts(
                                          //           context, id, details.id);
                                          //     },
                                          //     icon: const Icon(
                                          //         Icons.shopping_cart),
                                          //   ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: cubit.products.length,
                );
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

// import 'package:eccomerce/screens/home/logic/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key, required this.id});
//   final int id;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..getProducts(id),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Products'),
//         ),
//         body: SafeArea(
//           child: BlocBuilder<HomeCubit, HomeState>(
//             builder: (context, state) {
//               if (state is HomeLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is HomeError) {
//                 return const Center(child: Text('Failed to load products'));
//               } else if (state is HomeSuccess) {
//                 var cubit = HomeCubit.get(context);
//                 return ListView.separated(
//                   padding: const EdgeInsets.all(10),
//                   itemBuilder: (context, index) {
//                     final product = cubit.details[index];
//                     return InkWell(
//                       onTap: () {
//                     if (product.id != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProductsScreen(id: product.id),
//                         ),
//                       );
//                     } else {
//                       // Handle the case where id is null
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Category ID is null')),
//                       );
//                     }
//                   },
//                       child: Container(
//                         color: Colors.grey.shade200,
//                         padding: const EdgeInsets.all(10),
//                         child: Row(
//                           children: [
//                             Image.network(
//                               cubit.products[index].image,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(cubit.products[index].name),
//                                   Text('\$${cubit.products[index].price}'),
//                                   Row(
//                                     children: [
//                                       cubit.products[index].image != null?
//                                       IconButton(
//                                         onPressed: () {
//                                           cubit.addFavourites(
//                                               context, cubit.products[index].id,
//                                               id,
//                                               );
//                                         },
//                                         icon: const Icon(Icons.favorite_outline),
//                                       ):
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(Icons.shopping_cart),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const SizedBox(height: 10);
//                   },
//                   itemCount: cubit.products.length,
//                 );
//               } else {
//                 return const Center(child: Text('Unexpected State'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
