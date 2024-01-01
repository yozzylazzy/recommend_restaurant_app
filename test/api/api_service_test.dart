import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'api_service_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
const String _baseUrl = "https://restaurant-api.dicoding.dev";

@GenerateMocks([http.Client])
void main() {
  group('getAllRestaurants', () {
    late MockClient client;
    late ApiService apiService;

    setUp(() {
      client = MockClient();
      apiService = ApiService();
    });

    test('returns RestaurantsResult if the http call completes successfully',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/list'))).thenAnswer((_) async =>
          http.Response(
              '{"error":false,"message":"success","count":1,"restaurants":[{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet...","pictureId":"25","categories":[{"name":"Category 1"},{"name":"Category 2"}],"city":"Gorontalo","rating":4.5,"menus":{"foods":[{"name":"Food 1","price":"10.00"},{"name":"Food 2","price":"15.00"}],"drinks":[{"name":"Drink 1","price":"5.00"},{"name":"Drink 2","price":"8.00"}]},"customerReviews":[{"name":"Customer 1","review":"Good place","date":"2023-01-01"},{"name":"Customer 2","review":"Nice food","date":"2023-01-02"}]}]}',
              200));
      // Action
      final result = await apiService.getListRestaurant(client);
      // Assert
      expect(result, isA<RestaurantsResult>());
      expect(result.error, false);
      expect(result.message, "success");
      expect(result.restaurants.length, 1);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // Action & Assert
      expect(
          () async => await apiService.getListRestaurant(client),
          throwsA(predicate((dynamic e) =>
              e is Exception &&
              e.toString() == 'Exception: Failed to Load List Restaurants')));
    });
  });

  group('getDetailRestaurant', () {
    late MockClient client;
    late ApiService apiService;
    const String id = 's1knt6za9kkfw1e867';

    setUp(() {
      client = MockClient();
      apiService = ApiService();
    });

    test('returns RestaurantResult if the http call completes succesfully',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/detail/$id')))
          .thenAnswer((_) async => http.Response('''{
          "error": false,
          "message": "success",
          "restaurant": {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
          "city": "Gorontalo",
          "address": "Jln. Pustakawan no 9",
          "pictureId": "25",
          "categories": [{ "name": "Sop"  }, { "name": "Modern" }],
          "menus": {
          "foods": [{ "name": "Kari kacang dan telur" }, 
          { "name": "Ikan teri dan roti" },
          { "name": "roket penne" },
          { "name": "Salad lengkeng" },
          { "name": "Tumis leek" },
          { "name": "Salad yuzu" },
          { "name": "Sosis squash dan mint" }],
          "drinks": [
          { "name": "Jus tomat" },
          { "name": "Minuman soda" },
          { "name": "Jus apel" },
          { "name": "Jus mangga" },
          { "name": "Es krim" },
          { "name": "Kopi espresso" },
          { "name": "Jus alpukat" },
          { "name": "Coklat panas" },
          { "name": "Es kopi" },
          { "name": "Teh manis" },
          { "name": "Sirup" },
          { "name": "Jus jeruk"}]},
          "rating": 4,
          "customerReviews": [
          { "name": "Ahmad",
          "review": "Tidak ada duanya!",
          "date": "13 November 2019" },
          { "name": "Arif",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019" },
          { "name": "Gilang",
          "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
          "date": "14 Agustus 2018"
          }]}}''', 200));
      // Action
      final result = await apiService.getDetailRestaurant(client, id);
      print(result);
      // Assert
      expect(result, isA<RestaurantResult>());
      expect(result.error, false);
      expect(result.message, "success");
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/detail/iddummy')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // Action & Assert
      expect(
          () async => await apiService.getDetailRestaurant(client, 'iddummy'),
          throwsA(predicate((dynamic e) =>
              e is Exception &&
              e.toString() == 'Exception: Failed to Load Restaurant Detail')));
    });
  });

  group('searchRestaurant', () {
    late MockClient client;
    late ApiService apiService;
    const String query = 'fairy';

    setUp(() {
      client = MockClient();
      apiService = ApiService();
    });

    test('returns RestaurantsResult if the http call complete successfully',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/search?q=$query')))
          .thenAnswer((_) async => http.Response('''
          {"error": false,
          "founded": 1,
          "restaurants": [
          {"id": "w7jca3irwykfw1e867",
          "name": "Fairy Cafe",
          "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
          "pictureId": "24",
          "city": "Surabaya",
          "rating": 5}]}''', 200));
      // Action
      final result = await apiService.searchRestaurant(client, query);
      // Assert
      expect(result, isA<RestaurantsResult>());
      expect(result.error, false);
      expect(result.founded, 1);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Arrange
      when(client.get(Uri.parse('$_baseUrl/search?q=foundresses')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // Action & Assert
      expect(
          () async => await apiService.searchRestaurant(client, 'foundresses'),
          throwsA(predicate((dynamic e) =>
              e is Exception &&
              e.toString() ==
                  'Exception: Failed to Load Searched Restaurant')));
    });
  });
}
