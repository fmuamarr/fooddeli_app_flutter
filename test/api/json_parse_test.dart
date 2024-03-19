import 'dart:convert';

import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'json_parse_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('RestaurantResult', () {
    test('fromJSON decode test', () {
      const mockResponse = '''
      {
        "error": false,
        "message": "success",
        "count": 2,
        "restaurants": [
          {
            "id": "1",
            "name": "Restaurant A",
            "description": "Description A",
            "pictureId": "123",
            "city": "City A",
            "rating": 4.5
          },
          {
            "id": "2",
            "name": "Restaurant B",
            "description": "Description B",
            "pictureId": "456",
            "city": "City B",
            "rating": 4.2
          }
        ]
      }
      ''';

      final mockClient = MockClient();
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = RestaurantResult.fromJson(json.decode(mockResponse));

      expect(result.error, false);
      expect(result.message, 'success');
      expect(result.count, 2);
      expect(result.restaurants.length, 2);
    });
  });

  group('Restaurant', () {
    test('fromJson dari class Restaurant', () {
      const mockRestaurantJson = '''
      {
        "id": "1",
        "name": "Restaurant A",
        "description": "Description A",
        "pictureId": "123",
        "city": "City A",
        "rating": 4.5
      }
      ''';

      final restaurant = Restaurant.fromJson(json.decode(mockRestaurantJson));

      expect(restaurant.id, '1');
      expect(restaurant.name, 'Restaurant A');
      expect(restaurant.description, 'Description A');
      expect(restaurant.pictureId, '123');
      expect(restaurant.city, 'City A');
      expect(restaurant.rating, 4.5);
    });
  });
}
