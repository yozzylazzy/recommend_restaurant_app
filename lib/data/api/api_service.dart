import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';

class ApiService {
  static final String _baseUrl = dotenv.get('CLIENT_URL');

  Future<RestaurantsResult> getListRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load List Restaurants');
    }
  }

  Future<RestaurantResult> getDetailRestaurant(
      http.Client client, String id) async {
    final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant Detail');
    }
  }

  Future<RestaurantsResult> searchRestaurant(
      http.Client client, String query) async {
    final response = await client.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Searched Restaurant');
    }
  }

  Future<Restaurant> getRandomRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      final random = Random();
      List<Restaurant> listRestaurant =
          RestaurantsResult.fromJson(json.decode(response.body)).restaurants;
      Restaurant restaurant =
          listRestaurant[random.nextInt(listRestaurant.length)];
      return restaurant;
    } else {
      throw Exception('Failed Load List Restaurant');
    }
  }
}
