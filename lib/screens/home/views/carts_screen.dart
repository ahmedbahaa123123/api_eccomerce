import 'package:api_eccomerce/screens/home/widgets/custom_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Call getCart() when CartScreen is initialized
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<HomeCubit>(context).getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text('Failed to load cart: ${state.message}'));
          } else if (cubit.carts.isEmpty) {
            return const Center(child: Text('No items in cart'));
          } else {
            // Display CustomCart widget to show cart items
            return const CustomCart();
          }
        },
      ),
    );
  }
}
