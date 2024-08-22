import 'dart:convert';
import 'package:api_eccomerce/core/widget/uttils/constants/api_constatnts.dart';
import 'package:api_eccomerce/screens/home/data/banners_model.dart';
import 'package:api_eccomerce/screens/home/data/categories_model.dart';
import 'package:api_eccomerce/screens/home/data/products_model.dart';
import 'package:api_eccomerce/screens/home/data/profile_model.dart';
//import 'package:eccomerce/screens/home/views/searched_screen.dart';
//import 'package:eccomerce/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  List<CategoriesModel> categories = [];
  List<ProductsModel> products = []; // Correct naming to ProductModel
  List<BannersModel> banners = [];
  List<ProductsModel> favorites = [];
  List<ProductsModel> search = [];
  List<ProductsModel> carts = [];
   ProductsModel? details;
   ProfileModel? profile;
  final searchController = TextEditingController();
  
  void getCategories() async {
    emit(HomeLoading());
    var url = Uri.parse('${baseUrl}categories');
    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (result['status'] == true) {
        debugPrint('success $result');
        for (var element in result['data']['data'] as List) {
          categories.add(CategoriesModel.fromJson(element));
        }
        emit(HomeSuccess());
      } else {
        debugPrint('error $result');
        emit(HomeError(result['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }

  void getProducts(int categoryId) async {
    emit(HomeLoading());
    var url = Uri.parse('${baseUrl}products?category_id=$categoryId');
    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (result['status'] == true) {
        debugPrint('success $result');
        // products = (result['data']['data'] as List)
        //     .map((element) => ProductsModel.fromJson(element))
        //     .toList();
        for (var element in result['data']['data']) {
          products.add(ProductsModel.fromJson(element));
        }
        emit(HomeSuccess());
      } else {
        debugPrint('error $result');
        emit(HomeError(result['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }

  void getBanners() async {
    emit(HomeLoading());
    var url = Uri.parse('${baseUrl}banners');
    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (result['status'] == true) {
        debugPrint('success $result');
        // categories = (result['data'] as List)
        //     .map((element) => CategoriesModel.fromJson(element))
        //     .toList();
        for (var element in result['data']) {
          banners.add(BannersModel.fromJson(element));
        }

        emit(HomeSuccess());
      } else {
        debugPrint('error $result');
        emit(HomeError(result['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }

  Future<void> addFavourites(context, int id, int idCategory) async {
    var url = Uri.parse('${baseUrl}favorites');
    Map<String, dynamic> data = {
      "product_id": id,
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    String body = json.encode(data);
    try {
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        if (result['status'] == true) {
          debugPrint('success ${response.body}');
          getProducts(idCategory);
          emit(HomeSuccess());
          Navigator.pop(context, true);
        } else {
          debugPrint('error: ${result['message']}');
          emit(HomeError(result['message'] ?? 'Unknown error'));
        }
      } else {
        debugPrint('Failed to add favorite: ${response.body}');
        emit(HomeError('Failed to add favorite: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('error when adding: ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }

  void getFavorites() async {
  emit(HomeLoading());
  var url = Uri.parse('${baseUrl}favorites');
  final headers = {
    'content-type': 'application/json',
    'Authorization': token,
  };
  try {
    final response = await http.get(url, headers: headers);
    var result = json.decode(response.body);

    if (result['status'] == true) {
      //debugPrint('success $result');
      favorites.clear(); // Clear the favorites list before adding new items

      for (var element in result['data']['data']) {
        favorites.add(ProductsModel.fromJson(element['product']));
      }

      emit(HomeSuccess());
    } else {
      debugPrint('error $result');
      emit(HomeError(result['message'] ?? 'Unknown error'));
    }
  } catch (e) {
    debugPrint('error ${e.toString()}');
    emit(HomeError(e.toString()));
  }
}
void getCart() async {
  emit(HomeLoading());
  var url = Uri.parse('${baseUrl}carts');
  final headers = {
    'content-type': 'application/json',
    'Authorization': token,
  };
  try {
    final response = await http.get(url, headers: headers);
    var result = json.decode(response.body);

    if (result['status'] == true && result['data'] != null && result['data']['cart_items'] != null) {
      debugPrint('success $result');
      carts.clear(); // Clear the cart list before adding new items
      

      for (var element in result['data']['cart_items']) {
        if (element['product'] != null) {
          carts.add(ProductsModel.fromJson(element['product']));
        }
      }

      emit(HomeSuccess());
    } else {
      debugPrint('error $result');
      emit(HomeError(result['message'] ?? 'Unknown error'));
    }
  } catch (e) {
    debugPrint('error ${e.toString()}');
    emit(HomeError(e.toString()));
  }
}


  Future<void> addCarts(context, int id, int idCategory) async {
    var url = Uri.parse('${baseUrl}carts');
    Map<String, dynamic> data = {
      "product_id": id,
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    String body = json.encode(data);
    try {
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        if (result['status'] == true) {
          debugPrint('success ${response.body}');
          getProducts(idCategory);
          emit(HomeSuccess());
          //Navigator.pop(context, true);
        } else {
          debugPrint('error: ${result['message']}');
          emit(HomeError(result['message'] ?? 'Unknown error'));
        }
      } else {
        debugPrint('Failed to add cart: ${response.body}');
        emit(HomeError('Failed to add cart: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('error when adding: ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }
  Future<void> getProductsByName(BuildContext context) async {
  emit(HomeLoading());

  var url = Uri.parse('${baseUrl}products/search'); // Ensure this is the correct search endpoint
  Map<String, dynamic> data = {
    "text": searchController.text,
  };
      search.clear();
      products.clear();
  try {
    final response = await _postRequest(url, data);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      debugPrint('Response data: $responseData');
      
      if (responseData['data']['data']!= null) {
        for (var element in responseData['data']['data']) {
          search.add(ProductsModel.fromJson(element));
        }
        emit(HomeSuccess());
      } else {
        emit(HomeError('No products found'));
      }
    } else {
      debugPrint('Failed response: $responseData');
      emit(HomeError(responseData['message'] ?? 'Unknown error'));
    }
  } catch (e) {
    debugPrint('Error during add: ${e.toString()}');
    emit(HomeError(e.toString()));
  }
}
void getProductDetails(int productId) async {
  emit(HomeLoading());
  var url = Uri.parse('${baseUrl}products/$productId');
  try {
    final response = await http.get(url);
    var result = json.decode(response.body);

    if (result['status'] == true) {
      debugPrint('success $result');
      details = ProductsModel.fromJson(result['data']); // Parse single product details
      emit(HomeSuccess());
    } else {
      debugPrint('error $result');
      emit(HomeError(result['message'] ?? 'Unknown error'));
    }
  } catch (e) {
    debugPrint('error ${e.toString()}');
    emit(HomeError(e.toString()));
  }
}
 void getProfile() async {
  emit(HomeLoading());
  var url = Uri.parse('${baseUrl}profile'); // Ensure this is correct
  final headers = {
    'content-type': 'application/json',
    'Authorization': token, // Ensure the token is correct
  };

  try {
    debugPrint('Requesting URL: $url'); // Log the full URL
    final response = await http.get(url, headers: headers);

    debugPrint('Response status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      if (result['status'] == true) {
        var profileData = result['data'];
        if (profileData != null && profileData is Map<String, dynamic>) {
          profile = ProfileModel.fromJson(profileData);
          emit(HomeSuccess());
        } else {
          debugPrint('Profile data is null or not a map');
          emit(HomeError('Invalid profile data'));
        }
      } else {
        debugPrint('API error: $result');
        emit(HomeError(result['message'] ?? 'Unknown error'));
      }
    } else {
      debugPrint('HTTP error: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      emit(HomeError('Failed to load profile: HTTP ${response.statusCode}'));
    }
  } catch (e) {
    debugPrint('Exception: ${e.toString()}');
    emit(HomeError('Exception: ${e.toString()}'));
  }
}
Future<http.Response> _postRequest(Uri url, Map<String, dynamic> data) async {
  String body = json.encode(data);
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );
  return response;
}
}