import 'package:carousel_slider/carousel_slider.dart';
import 'package:api_eccomerce/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersSlider extends StatelessWidget {
  const BannersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (state is HomeLoading)?
        const Center(child:  CircularProgressIndicator()):
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            viewportFraction: 0.8,
            aspectRatio: 16/9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 1),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: cubit.banners.map((i) {
            return i.image != null?
             Image.network(
                height: 200,
                width: 400,
                fit: BoxFit.cover,
                i.image!
                ):
                Container(
                  color: Colors.grey.shade200,
                );
          }).toList(),
        );
      
      },
    );
  }
}
