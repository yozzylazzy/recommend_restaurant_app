import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  group('RestaurantResult Model fromJSON Parsing Test', () {
    Map<String, Object> restaurantJson = {};
    RestaurantResult expectedRestaurantResult = RestaurantResult();
    RestaurantResult failedRestaurantResult = RestaurantResult();

    setUp(() {
      restaurantJson = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description": "Quisque rutrum. Aenean imperdiet...",
          "pictureId": "25",
          "categories": [
            {"name": "Category 1"},
            {"name": "Category 2"}
          ],
          "city": "Gorontalo",
          "rating": 4.5,
          "menus": {
            "foods": [
              {"name": "Food 1"},
              {"name": "Food 2", "price": "15.00"}
            ],
            "drinks": [
              {"name": "Drink 1", "price": "5.00"},
              {"name": "Drink 2", "price": "8.00"}
            ]
          },
          "customerReviews": [
            {
              "name": "Customer 1",
              "review": "Good place",
              "date": "2023-01-01"
            },
            {"name": "Customer 2", "review": "Nice food", "date": "2023-01-02"}
          ]
        }
      };
      expectedRestaurantResult = RestaurantResult(
        error: false,
        message: "success",
        restaurant: Restaurant(
          id: "s1knt6za9kkfw1e867",
          name: "Kafe Kita",
          description: "Quisque rutrum. Aenean imperdiet...",
          pictUrl: "25",
          categories: ["Category 1", "Category 2"],
          city: "Gorontalo",
          rating: 4.5,
          menus: {
            "foods": [
              {"name": "Food 1"},
              {"name": "Food 2"}
            ],
            "drinks": [
              {"name": "Drink 1"},
              {"name": "Drink 2"}
            ]
          },
          customerReviews: [
            CustomerReview(
                name: "Customer 1", review: "Good place", date: "2023-01-01"),
            CustomerReview(
                name: "Customer 2", review: "Nice food", date: "2023-01-02")
          ],
        ),
      );
      failedRestaurantResult = RestaurantResult(
        error: false,
        message: 'success',
        restaurant: null,
      );
    });

    test('should successfully parse JSON to RestaurantResult', () async {
      // Action
      var result = RestaurantResult.fromJson(restaurantJson);
      // Assert
      expect(result.error, equals(expectedRestaurantResult.error));
      expect(result.message, equals(expectedRestaurantResult.message));
      expect(result.restaurant?.id,
          equals(expectedRestaurantResult.restaurant?.id));
      expect(result.restaurant?.name,
          equals(expectedRestaurantResult.restaurant?.name));
      expect(result.restaurant?.description,
          equals(expectedRestaurantResult.restaurant?.description));
      expect(result.restaurant?.pictUrl,
          equals(expectedRestaurantResult.restaurant?.pictUrl));
      expect(result.restaurant?.categories,
          equals(expectedRestaurantResult.restaurant?.categories));
      expect(result.restaurant?.city,
          equals(expectedRestaurantResult.restaurant?.city));
      expect(result.restaurant?.rating,
          equals(expectedRestaurantResult.restaurant?.rating));
      expect(result.restaurant?.customerReviews?.length,
          equals(expectedRestaurantResult.restaurant?.customerReviews?.length));
    });

    test('should return JSON error message', () async {
      // Arrange
      expectedRestaurantResult.restaurant = null;
      // Action & Assert
      expect(
          expectedRestaurantResult.error, equals(failedRestaurantResult.error));
      expect(expectedRestaurantResult.message,
          equals(failedRestaurantResult.message));
      expect(expectedRestaurantResult.restaurant,
          equals(failedRestaurantResult.restaurant));
    });

    test('should return CustomerReviews class correctly', () async {
      // Arrange
      const testCustomerReviews = {
        "name": "Customer 1",
        "review": "Good place",
        "date": "2023-01-01"
      };
      // Action
      var expectedCustomerReview = CustomerReview(
        name: 'Customer 1',
        review: "Good place",
        date: "2023-01-01",
      );
      var result = CustomerReview.fromJson(testCustomerReviews);
      // Assert
      expect(result, equals(isA<CustomerReview>()));
      expect(result.name, equals(expectedCustomerReview.name));
      expect(result.review, equals(expectedCustomerReview.review));
      expect(result.date, equals(expectedCustomerReview.date));
    });
  });

  group('RestaurantsResult Model fromJSON Parsing Test', () {
    Map<String, Object> restaurantsJson = {};
    RestaurantsResult expectedRestaurantsResult = RestaurantsResult();
    RestaurantsResult failedRestaurantsResult = RestaurantsResult();

    setUp(() {
      restaurantsJson = {
        "error": false,
        "message": "success",
        "count": 2,
        "founded": 2,
        "restaurants": [
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet...",
            "pictureId": "25",
            "categories": [
              {"name": "Category 1"},
              {"name": "Category 2"}
            ],
            "city": "Gorontalo",
            "rating": 4.5,
            "menus": {
              "foods": [
                {"name": "Food 1"},
                {"name": "Food 2", "price": "15.00"}
              ],
              "drinks": [
                {"name": "Drink 1", "price": "5.00"},
                {"name": "Drink 2", "price": "8.00"}
              ]
            },
            "customerReviews": [
              {
                "name": "Customer 1",
                "review": "Good place",
                "date": "2023-01-01"
              },
              {
                "name": "Customer 2",
                "review": "Nice food",
                "date": "2023-01-02"
              }
            ]
          },
        ]
      };
      expectedRestaurantsResult = RestaurantsResult(
        error: false,
        message: "success",
        count: 2,
        founded: 2,
        restaurants: [
          Restaurant(
            id: "s1knt6za9kkfw1e867",
            name: "Kafe Kita",
            description: "Quisque rutrum. Aenean imperdiet...",
            pictUrl: "25",
            categories: ["Category 1", "Category 2"],
            city: "Gorontalo",
            rating: 4.5,
            menus: {
              "foods": [
                {"name": "Food 1"},
                {"name": "Food 2"}
              ],
              "drinks": [
                {"name": "Drink 1"},
                {"name": "Drink 2"}
              ]
            },
            customerReviews: [
              CustomerReview(
                name: "Customer 1",
                review: "Good place",
                date: "2023-01-01",
              ),
              CustomerReview(
                name: "Customer 2",
                review: "Nice food",
                date: "2023-01-02",
              ),
            ],
          ),
        ],
      );
      failedRestaurantsResult = RestaurantsResult(
        error: false,
        message: 'success',
        count: 0,
        founded: 0,
        restaurants: [],
      );
    });

    test('should successfully parse JSON to RestaurantsResult', () async {
      // Action
      var result = RestaurantsResult.fromJson(restaurantsJson);
      // Assert
      expect(result.error, equals(expectedRestaurantsResult.error));
      expect(result.message, equals(expectedRestaurantsResult.message));
      expect(result.count, equals(expectedRestaurantsResult.count));
      expect(result.founded, equals(expectedRestaurantsResult.founded));
    });

    test('should return JSON error payload', () async {
      // Arrange
      expectedRestaurantsResult.restaurants = [];
      // Action & Assert
      expect(
        expectedRestaurantsResult.error,
        equals(failedRestaurantsResult.error),
      );
      expect(expectedRestaurantsResult.message,
          equals(failedRestaurantsResult.message));
      expect(expectedRestaurantsResult.restaurants.length,
          equals(failedRestaurantsResult.count));
      expect(expectedRestaurantsResult.restaurants.length,
          equals(failedRestaurantsResult.founded));
    });
  });
}
