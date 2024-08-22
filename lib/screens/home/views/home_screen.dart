import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:api_eccomerce/screens/home/views/searched_screen.dart';
import 'package:api_eccomerce/screens/home/widgets/banners_slider.dart';
//import 'package:eccomerce/screens/home/views/products_screen.dart';
import 'package:api_eccomerce/screens/home/widgets/categories_list.dart';
import 'package:api_eccomerce/screens/home/widgets/custom_cart.dart';
import 'package:api_eccomerce/screens/home/widgets/favorites_grid.dart';
import 'package:api_eccomerce/screens/home/widgets/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  //final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HELLOooooo!'),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()
          ..getCategories()
          ..getBanners()
          ..getFavorites()
          ..getCart(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "search🤪",
                              icon: const Icon(Icons.search),
                              controller: cubit.searchController,
                               onChanged: (value) {
                                // Perform any action you want when the text changes
                                print("Search term: $value");
                              },
                              
                            ),
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
                        ],
                      ),

                      // categories
                      const CategoriesList(),
                      const SizedBox(
                        height: 10,
                      ),
                      const BannersSlider(),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "favourites",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      
                      const FavoritesGrid(),
                      const SizedBox(
                        height: 50,
                      ),
                      
                      
                     // const Home2GridView(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
