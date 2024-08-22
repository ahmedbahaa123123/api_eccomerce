import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:api_eccomerce/screens/home/widgets/search_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedScreen extends StatelessWidget {
  final String searchTerm;

  const SearchedScreen({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getProductsByName(context),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text('Failed to load products: ${state.message}'));
            } else if (state is HomeSuccess) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: searchTerm,
                            border: const OutlineInputBorder(),
                          ),
                          controller: cubit.searchController..text = searchTerm,
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.getProductsByName(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchedScreen(
                                    searchTerm: cubit.searchController.text,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.search),
                          ),
                        const SizedBox(height: 10),
                        const SearchGridView(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Unexpected State'));
            }
          },
        ),
      ),
    );
  }
}


// import 'package:eccomerce/screens/home/logic/home_cubit.dart';
// import 'package:eccomerce/screens/home/widgets/search_grid_view.dart';
// import 'package:eccomerce/screens/home/widgets/text_field_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SearchedScreen extends StatelessWidget {
//   final String searchTerm;
//   const SearchedScreen({super.key, required this.searchTerm});
// //final int id;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: BlocProvider(
//         create: (context) => HomeCubit(),
//         child: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             var cubit = HomeCubit.get(context);
//             return SafeArea(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 labelText: searchTerm,
//                                 border: const OutlineInputBorder(),
//                               ),
//                               controller: cubit.searchController
//                                 ..text = searchTerm,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               cubit.getProductsByName(context);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SearchedScreen(
//                                     searchTerm: cubit.searchController.text,
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.search),
//                           ),
//                         ],
//                       ),
//                       const SearchGridView(),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
