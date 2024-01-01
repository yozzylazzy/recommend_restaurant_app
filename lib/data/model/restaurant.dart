import 'dart:convert';

abstract class Result {
  final bool error;
  final String? message;

  Result({
    required this.error,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}

class RestaurantsResult extends Result {
  int? count, founded;
  List<Restaurant> restaurants;

  RestaurantsResult({
    this.count = 0,
    this.founded = 0,
    this.restaurants = const [],
    bool error = true,
    String? message,
  }) : super(error: error, message: message);

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"]
            .map((x) => Restaurant.fromJson(x))
            .where((restaurant) =>
                restaurant.name != null && restaurant.pictUrl != null)),
      );

  @override
  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantResult extends Result {
  Restaurant? restaurant;

  RestaurantResult({
    this.restaurant,
    bool error = true,
    String? message,
  }) : super(
          error: error,
          message: message,
        );

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json['restaurant']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant,
      };
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictUrl;
  final List<String> categories;
  final String city;
  final double rating;
  final Map<String, List<Map<String, String>>>? menus;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictUrl,
    required this.categories,
    required this.city,
    required this.rating,
    this.menus,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictUrl: restaurant['pictureId'],
        categories: (restaurant['categories'] as List<dynamic>?)
                ?.map((category) => category['name'] as String)
                .toList() ??
            [],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: {
          'foods': (restaurant['menus']?['foods'] as List<dynamic>?)
                  ?.map((food) => Map<String, String>.from(food))
                  .toList() ??
              [], // If 'foods' is null, provide an empty list
          'drinks': (restaurant['menus']?['drinks'] as List<dynamic>?)
                  ?.map((drink) => Map<String, String>.from(drink))
                  .toList() ??
              [], // If 'drinks' is null, provide an empty list
        },
        customerReviews: List<CustomerReview>.from(restaurant["customerReviews"]
                ?.map((review) => CustomerReview.fromJson(review)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictUrl": pictUrl,
        "categories": categories,
        "city": city,
        "rating": rating,
        "menus": menus,
        "customerReviews": List<dynamic>.from(
            customerReviews?.map((review) => review.toJson()) ?? []),
      };

  Map<String, dynamic> toJsonSql() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictUrl,
      'city': city,
      'rating': rating,
    };
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  final List<dynamic> parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
