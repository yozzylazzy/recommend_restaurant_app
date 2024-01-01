import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper_test.mocks.dart';
// flutter packages pub run build_runner build --delete-conflicting-outputs

@GenerateMocks([Restaurant, DatabaseHelper])
void main() {
  late Database database;
  late MockDatabaseHelper mockDatabaseHelper;
  late Restaurant testRestaurant;
  late Map<String, dynamic> resultRestaurant;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    testRestaurant = Restaurant(
        id: 'id-123',
        name: 'restaurant-123',
        description: 'Lorem Ipsum Dicoding',
        pictUrl: '24',
        categories: [],
        city: 'Bandung',
        rating: 5.0);
    resultRestaurant = {
      'id': 'id-123',
      'name': 'restaurant-123',
      'description': 'Lorem Ipsum Dicoding',
      'pictureId': '24',
      'city': 'Bandung',
      'rating': 5.0
    };
  });

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    database = await databaseFactory.openDatabase(inMemoryDatabasePath);
  });

  group('addFavorite', () {
    test('addFavorite should insert data into the database', () async {
      // Stub
      when(mockDatabaseHelper.addFavorite(any)).thenAnswer((_) async {});
      // Action
      await mockDatabaseHelper.addFavorite(testRestaurant);
      // Assert
      verify(mockDatabaseHelper.addFavorite(testRestaurant)).called(1);
    });
  });

  group('getRestaurants', () {
    test('getRestaurants should return a list of restaurants', () async {
      // Stub
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => [testRestaurant]);
      final testResults = [
        {'id': 'id-123', 'name': 'restaurant-123', 'rating': 5},
      ];
      // Action
      final restaurants = await mockDatabaseHelper.getRestaurants();
      // Assert
      expect(restaurants.length, testResults.length);
      expect(restaurants[0].id, testResults[0]['id']);
      expect(restaurants[0].name, testResults[0]['name']);
      expect(restaurants[0].rating, testResults[0]['rating']);
    });
  });

  group('getFavoriteById', () {
    test('getFavoriteById should return a map of the specified restaurant',
        () async {
      // Stub
      when(mockDatabaseHelper.getFavoriteById(any))
          .thenAnswer((_) async => resultRestaurant);
      // Arrange
      const testId = 'id-123';
      // Action
      final favorite = await mockDatabaseHelper.getFavoriteById(testId);
      // Assert
      expect(favorite, resultRestaurant);
    });
  });

  group('removeFavorite', () {
    test('removeFavorite should delete the specified restaurant', () async {
      // Stub
      when(mockDatabaseHelper.removeFavorite(any)).thenAnswer((_) async {});
      // Arrange
      const testId = 'id-123';
      // Action
      await mockDatabaseHelper.removeFavorite(testId);
      // Assert
      verify(mockDatabaseHelper.removeFavorite(testId)).called(1);
    });
  });
}
