// Mocks generated by Mockito 5.4.4 from annotations
// in restaurant_app/test/provider/database_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:restaurant_app/data/db/database_helper.dart' as _i2;
import 'package:restaurant_app/data/model/restaurant.dart' as _i5;
import 'package:restaurant_app/provider/database_provider.dart' as _i6;
import 'package:restaurant_app/utils/result_state.dart' as _i7;
import 'package:sqflite/sqflite.dart' as _i4;

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

class _FakeDatabaseHelper_0 extends _i1.SmartFake
    implements _i2.DatabaseHelper {
  _FakeDatabaseHelper_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i2.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i3.Future<_i4.Database?>.value(),
      ) as _i3.Future<_i4.Database?>);

  @override
  _i3.Future<void> addFavorite(_i5.Restaurant? restaurant) =>
      (super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [restaurant],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i5.Restaurant>> getRestaurants() => (super.noSuchMethod(
        Invocation.method(
          #getRestaurants,
          [],
        ),
        returnValue: _i3.Future<List<_i5.Restaurant>>.value(<_i5.Restaurant>[]),
      ) as _i3.Future<List<_i5.Restaurant>>);

  @override
  _i3.Future<Map<dynamic, dynamic>> getFavoriteById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteById,
          [id],
        ),
        returnValue:
            _i3.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
      ) as _i3.Future<Map<dynamic, dynamic>>);

  @override
  _i3.Future<void> removeFavorite(String? id) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [DatabaseProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseProvider extends _i1.Mock implements _i6.DatabaseProvider {
  MockDatabaseProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseHelper get databaseHelper => (super.noSuchMethod(
        Invocation.getter(#databaseHelper),
        returnValue: _FakeDatabaseHelper_0(
          this,
          Invocation.getter(#databaseHelper),
        ),
      ) as _i2.DatabaseHelper);

  @override
  _i7.ResultState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i7.ResultState.loading,
      ) as _i7.ResultState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  List<_i5.Restaurant> get favorites => (super.noSuchMethod(
        Invocation.getter(#favorites),
        returnValue: <_i5.Restaurant>[],
      ) as List<_i5.Restaurant>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void addFavorite(_i5.Restaurant? restaurant) => super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [restaurant],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<bool> isFavorited(String? id) => (super.noSuchMethod(
        Invocation.method(
          #isFavorited,
          [id],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  void removeFavorited(String? id) => super.noSuchMethod(
        Invocation.method(
          #removeFavorited,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(dynamic listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
