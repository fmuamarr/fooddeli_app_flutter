import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/src/data/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

final restaurant = Restaurant(
  id: '111',
  name: 'Restaurant A',
  description: 'Lorem Ipsum',
  pictureId: '1',
  city: 'City',
  rating: 4.5,
);

Future main() async {
  sqfliteTestInit();

  late DatabaseHelper databaseHelper;
  late Database db;

  setUp(() async {
    databaseHelper = DatabaseHelper();
    db = await openDatabase(inMemoryDatabasePath);
    await db.close();
    db = await openDatabase(inMemoryDatabasePath);

    await db.execute('''
      CREATE TABLE favorite (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )     
    ''');
  });

  tearDown(() async {
    await db.delete('favorite');
  });

  group('test fungsi database', () {
    test('Fungsi database', () async {
      // Insert fungsi favorite
      await databaseHelper.insertFavorite(restaurant);

      // Test fungsi getFavorites
      final favorites = await databaseHelper.getFavorites();
      expect(favorites.length, 1);
      expect(favorites.first.id, restaurant.id);
      expect(favorites.first.name, restaurant.name);
      expect(favorites.first.description, restaurant.description);
      expect(favorites.first.pictureId, restaurant.pictureId);
      expect(favorites.first.city, restaurant.city);
      expect(favorites.first.rating, restaurant.rating);
    });

    test('fungsi getById', () async {
      // Test fungsi getFavoriteById
      final favoriteById = await databaseHelper.getFavoriteById('111');
      expect(favoriteById['id'], restaurant.id);
      expect(favoriteById['name'], restaurant.name);
      expect(favoriteById['description'], restaurant.description);
      expect(favoriteById['pictureId'], restaurant.pictureId);
      expect(favoriteById['city'], restaurant.city);
      expect(favoriteById['rating'], restaurant.rating);
    });

    test('fungsi delete', () async {
      // Test fungsi removeFavorite
      await databaseHelper.removeFavorite('111');
      final favoritesAfterRemoval = await databaseHelper.getFavorites();
      expect(favoritesAfterRemoval.length, 0);
    });
  });
}
