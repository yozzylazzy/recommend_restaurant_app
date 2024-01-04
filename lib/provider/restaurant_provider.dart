import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/api_exception.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late RestaurantsResult _restaurantsResult, _searchResult;
  RestaurantResult? _restaurantResult;

  late ResultState _stateList,
      _stateDetail = ResultState.loading,
      _stateSearch = ResultState.loading;
  String _message = '';

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  RestaurantsResult get search => _searchResult;

  RestaurantResult? get detail => _restaurantResult;

  ResultState get stateList => _stateList;

  ResultState get stateDetail => _stateDetail;

  ResultState get stateSearch => _stateSearch;

  Future<dynamic> fetchAllRestaurants() async {
    try {
      _stateList = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant(http.Client());
      if (restaurant.restaurants.isEmpty) {
        _stateList = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _stateList = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } on SocketException {
      _stateList = ResultState.error;
      _message = 'Internet Connection Failed!';
      notifyListeners();
    } catch (e) {
      _stateList = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _stateDetail = ResultState.loading;
      notifyListeners();
      final restaurant =
          await apiService.getDetailRestaurant(http.Client(), id);
      if (restaurant.restaurant == null) {
        _stateDetail = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _stateDetail = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } on SocketException {
      _stateDetail = ResultState.error;
      _message = 'Internet Connection Failed!';
      notifyListeners();
    } catch (e) {
      _stateDetail = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _stateSearch = ResultState.loading;
      notifyListeners();
      if (query.isNotEmpty) {
        final restaurant =
            await apiService.searchRestaurant(http.Client(), query);
        if (restaurant.restaurants.isEmpty) {
          _stateSearch = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _stateSearch = ResultState.hasData;
          notifyListeners();
          return _searchResult = restaurant;
        }
      } else {
        _stateSearch = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } on SocketException {
      _stateSearch = ResultState.error;
      _message = 'Internet Connection Failed!';
      notifyListeners();
    } catch (e) {
      _stateSearch = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }
}
