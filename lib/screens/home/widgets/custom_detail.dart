
import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDetail extends StatelessWidget {
  const CustomDetail({super.key, required this.id});
final int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return const Center(child: Text('Failed to load products'));
        } else if (state is HomeSuccess) {
          var cubit = HomeCubit.get(context);
          var details = cubit.details; // Single product details
          if (details == null) {
            return const Center(child: Text('No product details available'));
          }
          return Scaffold(
            appBar: AppBar(title: const Text('Product Details')),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Image.network(details.image), // Assuming details has an image
                  ),
                  Text(
                    details.name, // Assuming details has a name
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      details.description, // Assuming details has a description
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const Text(
                        '1', // Quantity should be dynamic if needed
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurpleAccent,
                ),
                child:  Center(
                  child: ElevatedButton(
                    onPressed: (){
                      cubit.addCarts(context, id, details.id);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox(); // Default case to handle unexpected states
        }
      },
    );
  }
}
