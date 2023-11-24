import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Favorite,
  MyCreation,
  InspirationFavorite,
  ModelFavorite,
  PromptHistory
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 17;

  Future<List<FavoriteData>> getAllFavorite() async {
    return await select(favorite).get();
  }

  Future<int> saveFavorite(FavoriteCompanion companion) async {
    return await into(favorite)
        .insert(companion, mode: InsertMode.insertOrIgnore);
  }

  Future<int> deleteFavorite(String name) async {
    return (delete(favorite)..where((val) => favorite.description.equals(name)))
        .go();
  }

  Future<bool> isFavorite(String path) async {
    final query = select(favorite)
      ..where((val) => favorite.imagePath.equals(path));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<List<ModelFavoriteData>> getAllModelFavorite() async {
    return await select(modelFavorite).get();
  }

  Future<int> saveModelFavorite(ModelFavoriteCompanion companion) async {
    print("saviong");
    return await into(modelFavorite)
        .insert(companion, mode: InsertMode.insertOrIgnore);
  }

  Future<int> deleteModelFavorite(String name) async {
    return (delete(modelFavorite)
          ..where((val) => modelFavorite.modelName.equals(name)))
        .go();
  }

  Future<bool> isModelFavorite(String path) async {
    final query = select(modelFavorite)
      ..where((val) => modelFavorite.path.equals(path));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<int> saveCreations({
    required String imagePath,
    required String description,
    required bool isFavorite,
  }) async {
    try {
      return await into(myCreation).insert(
        MyCreationCompanion(
          imagePath: Value(imagePath),
          description: Value(description),
          isFavorite: Value(isFavorite),
        ),
      );
    } catch (e) {
      // Handle any errors or exceptions here
      if (kDebugMode) {
        print('Error saving creation: $e');
      }
      return 99;
    }
  }

  Future<List<MyCreationData>> getAllCreations() async {
    try {
      final query = select(myCreation);
      return query.get();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting all creations: $e');
      }
      return [];
    } finally {}
  }

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (m, from, to) async {
        await m.createTable(favorite);
        await m.createTable(myCreation);
        await m.createTable(inspirationFavorite);
        await m.createTable(modelFavorite);
        await m.createTable(promptHistory);
        if (kDebugMode) {
          print("Version---->$m----$to");
        }
      });

  Future<int> saveInspiration(InspirationFavoriteCompanion companion) async {
    return await into(inspirationFavorite)
        .insert(companion, mode: InsertMode.insertOrIgnore);
  }

  Future<int> deleteInspiration(String path) async {
    return (delete(inspirationFavorite)
          ..where((val) => inspirationFavorite.path.equals(path)))
        .go();
  }

  Future<List<InspirationFavoriteData>> getAllInspiration() async {
    return await select(inspirationFavorite).get();
  }

  Future<bool> isInspirationFavorite(String path) async {
    final query = select(inspirationFavorite)
      ..where((val) => inspirationFavorite.path.equals(path));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<List<PromptHistoryData>> getAllPromptHistory() async {
    return await select(promptHistory).get();
  }

  Future<int> savePromptHistory(PromptHistoryCompanion companion) async {
    return await into(promptHistory)
        .insert(companion, mode: InsertMode.insertOrIgnore);
  }

  Future<int> deletePromptHistory(String name) async {
    return (delete(promptHistory)
          ..where((val) => promptHistory.prompt.equals(name)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'aiArt_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

class MyCreation extends Table {
  IntColumn get id => integer().named("Id")();

  TextColumn get imagePath => text().named('imagePath')();

  TextColumn get description => text().named('description')();

  BoolColumn get isFavorite => boolean().named('isFavorite')();
}

class Favorite extends Table {
  IntColumn get id => integer().named("Id")();

  TextColumn get imagePath => text()
      .withLength(
        min: 1,
      )
      .named("Path")();

  TextColumn get description => text()
      .withLength(
        min: 1,
        max: 500,
      )
      .named('Prompt')();

  TextColumn get type => text()
      .withLength(
        min: 1,
        max: 100,
      )
      .named('Type')();

  BoolColumn get isFavorite => boolean().named("Favorite")();

  @override
  Set<Column> get primaryKey => {imagePath};
}

class InspirationFavorite extends Table {
  IntColumn get id => integer().named("Id")();

  TextColumn get path => text()
      .withLength(
        min: 1,
      )
      .named("Path")();

  TextColumn get command => text()
      .withLength(
        min: 1,
        max: 500,
      )
      .named('command')();

  BoolColumn get proUserAccess => boolean().named('proUserAccess')();

  BoolColumn get isFavorite => boolean().named("Favorite")();

  @override
  Set<Column> get primaryKey => {path};
}

class ModelFavorite extends Table {
  IntColumn get id => integer().named("Id")();

  TextColumn get path => text()
      .withLength(
        min: 1,
      )
      .named("ImagePath")();

  TextColumn get modelName => text()
      .withLength(
        min: 1,
        max: 500,
      )
      .named('ModelName')();

  BoolColumn get proUserAccess => boolean().named('proUserAccess')();

  BoolColumn get isFavorite => boolean().named("Favorite")();

  @override
  Set<Column> get primaryKey => {path};
}

class PromptHistory extends Table {
  IntColumn get id => integer().named("Id")();

  TextColumn get prompt => text()
      .withLength(
        min: 1,
        max: 500,
      )
      .named("Prompt")();

  // ColumnBuilder<DateTime> get history => dateTime();
  DateTimeColumn get created =>
      dateTime().withDefault(currentDateAndTime).named('created')();

  @override
  Set<Column> get primaryKey => {prompt};
}
