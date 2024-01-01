import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import '../db/database_helper_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late DatabaseProvider databaseProvider;
  late Restaurant testRestaurant;

  setUp(() {
    testRestaurant = Restaurant(
        id: 'id-123',
        name: 'restaurant-123',
        description: 'Lorem Ipsum Dicoding',
        pictUrl: '24',
        categories: [],
        city: 'Bandung',
        rating: 5.0);
    mockDatabaseHelper = MockDatabaseHelper();
    when(mockDatabaseHelper.getRestaurants())
        .thenAnswer((_) async => [testRestaurant]);
    databaseProvider = DatabaseProvider(databaseHelper: mockDatabaseHelper);
  });

  group('addFavorite', () {
    test(
        'Add favorite should hasData and have return same amount of restaurant',
        () async {
      final expectedFavorites = [
        Restaurant(
            id: 'id-123',
            name: 'restaurant-123',
            description: 'Lorem Ipsum Dicoding',
            pictUrl: '24',
            categories: [],
            city: 'Bandung',
            rating: 5.0)
      ];
      // Stub the addFavorite and getRestaurants methods
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      // Act
      databaseProvider.addFavorite(testRestaurant);
      // Assert
      verify(mockDatabaseHelper.addFavorite(testRestaurant)).called(1);
      verify(mockDatabaseHelper.getRestaurants()).called(1);
      expect(
          databaseProvider.favorites.length, equals(expectedFavorites.length));
      expect(databaseProvider.state, ResultState.hasData);
    });
  });

  group('getFavorite', () {
    test(
        'get favorite by id should hasData and have return same amount of restaurant',
        () async {
      // Stub the addFavorite and getRestaurants methods
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      when(mockDatabaseHelper.getFavoriteById(testRestaurant.id))
          .thenAnswer((_) async => {'id': testRestaurant.id});
      databaseProvider.addFavorite(testRestaurant);
      // Act
      final isFavorited = await databaseProvider.isFavorited(testRestaurant.id);
      // Assert
      verify(mockDatabaseHelper.getFavoriteById(testRestaurant.id)).called(1);
      expect(isFavorited, true);
      expect(databaseProvider.state, ResultState.hasData);
    });
  });

  group('removeFavorite', () {
    test(
        'remove favorited should remove the restaurant update state to hasData',
        () async {
      // Stub the addFavorite and getRestaurants methods
      when(mockDatabaseHelper.addFavorite(testRestaurant))
          .thenAnswer((_) async {});
      when(mockDatabaseHelper.getRestaurants())
          .thenAnswer((_) async => <Restaurant>[]);
      when(mockDatabaseHelper.getFavoriteById(testRestaurant.id))
          .thenAnswer((_) async => {'id': testRestaurant.id});
      databaseProvider.addFavorite(testRestaurant);
      // Act
      databaseProvider.removeFavorited(testRestaurant.id);
      // Assert
      verify(mockDatabaseHelper.removeFavorite(testRestaurant.id)).called(1);
      verify(mockDatabaseHelper.getRestaurants()).called(1);
      expect(databaseProvider.state, ResultState.hasData);
    });
  });
}
