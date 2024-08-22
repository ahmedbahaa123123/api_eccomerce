
import 'package:api_eccomerce/screens/auth/views/login_screen.dart';
import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:api_eccomerce/screens/home/views/carts_screen.dart';
import 'package:api_eccomerce/screens/home/views/home_screen.dart';
import 'package:api_eccomerce/screens/home/views/rating_bar.dart';
import 'package:api_eccomerce/screens/home/views/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  // Make sure to import this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..getCategories()
            ..getBanners()
            ..getFavorites()
            ..getCart(),
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const UserDetailsScreen(),
    const CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        // Reload the cart when navigating to the cart screen
        BlocProvider.of<HomeCubit>(context).getCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 3
          ? AnimatedRatingBar(
              activeFillColor: Theme.of(context).colorScheme.inversePrimary,
              strokeColor: Theme.of(context).colorScheme.inversePrimary,
              initialRating: 4.0,
              height: 60,
              width: MediaQuery.of(context).size.width,
              animationColor: Theme.of(context).colorScheme.inversePrimary,
              onRatingUpdate: (rating) {
                debugPrint(rating.toString());
              },
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rate',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
