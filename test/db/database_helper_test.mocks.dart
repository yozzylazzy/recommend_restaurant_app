// Mocks generated by Mockito 5.4.4 from annotations
// in restaurant_app/test/db/database_helper_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;
import 'package:restaurant_app/data/db/database_helper.dart' as _i4;
import 'package:restaurant_app/data/model/restaurant.dart' as _i2;
import 'package:sqflite/sqflite.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [Restaurant].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestaurant extends _i1.Mock implements _i2.Restaurant {
  MockRestaurant() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#id),
        ),
      ) as String);

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  String get description => (super.noSuchMethod(
        Invocation.getter(#description),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#description),
        ),
      ) as String);

  @override
  String get pictUrl => (super.noSuchMethod(
        Invocation.getter(#pictUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#pictUrl),
        ),
      ) as String);

  @override
  List<String> get categories => (super.noSuchMethod(
        Invocation.getter(#categories),
        returnValue: <String>[],
      ) as List<String>);

  @override
  String get city => (super.noSuchMethod(
        Invocation.getter(#city),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#city),
        ),
      ) as String);

  @override
  double get rating => (super.noSuchMethod(
        Invocation.getter(#rating),
        returnValue: 0.0,
      ) as double);

  @override
  Map<String, dynamic> toJson() => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJsonSql() => (super.noSuchMethod(
        Invocation.method(
          #toJsonSql,
          [],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i4.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i6.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i5.Future<_i6.Database?>.value(),
      ) as _i5.Future<_i6.Database?>);

  @override
  _i5.Future<void> addFavorite(_i2.Restaurant? restaurant) =>
      (super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [restaurant],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<List<_i2.Restaurant>> getRestaurants() => (super.noSuchMethod(
        Invocation.method(
          #getRestaurants,
          [],
        ),
        returnValue: _i5.Future<List<_i2.Restaurant>>.value(<_i2.Restaurant>[]),
      ) as _i5.Future<List<_i2.Restaurant>>);

  @override
  _i5.Future<Map<dynamic, dynamic>> getFavoriteById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteById,
          [id],
        ),
        returnValue:
            _i5.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
      ) as _i5.Future<Map<dynamic, dynamic>>);

  @override
  _i5.Future<void> removeFavorite(String? id) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}