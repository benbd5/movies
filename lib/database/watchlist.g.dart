// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchlistCollection on Isar {
  IsarCollection<Watchlist> get watchlists => this.collection();
}

const WatchlistSchema = CollectionSchema(
  name: r'Watchlist',
  id: -4611123093172739066,
  properties: {
    r'type': PropertySchema(
      id: 0,
      name: r'type',
      type: IsarType.string,
    ),
    r'watchIds': PropertySchema(
      id: 1,
      name: r'watchIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _watchlistEstimateSize,
  serialize: _watchlistSerialize,
  deserialize: _watchlistDeserialize,
  deserializeProp: _watchlistDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _watchlistGetId,
  getLinks: _watchlistGetLinks,
  attach: _watchlistAttach,
  version: '3.1.0+1',
);

int _watchlistEstimateSize(
  Watchlist object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.watchIds.length * 8;
  return bytesCount;
}

void _watchlistSerialize(
  Watchlist object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.type);
  writer.writeLongList(offsets[1], object.watchIds);
}

Watchlist _watchlistDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Watchlist();
  object.id = id;
  object.type = reader.readString(offsets[0]);
  object.watchIds = reader.readLongList(offsets[1]) ?? [];
  return object;
}

P _watchlistDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchlistGetId(Watchlist object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _watchlistGetLinks(Watchlist object) {
  return [];
}

void _watchlistAttach(IsarCollection<dynamic> col, Id id, Watchlist object) {
  object.id = id;
}

extension WatchlistQueryWhereSort
    on QueryBuilder<Watchlist, Watchlist, QWhere> {
  QueryBuilder<Watchlist, Watchlist, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WatchlistQueryWhere
    on QueryBuilder<Watchlist, Watchlist, QWhereClause> {
  QueryBuilder<Watchlist, Watchlist, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchlistQueryFilter
    on QueryBuilder<Watchlist, Watchlist, QFilterCondition> {
  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition> watchIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterFilterCondition>
      watchIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WatchlistQueryObject
    on QueryBuilder<Watchlist, Watchlist, QFilterCondition> {}

extension WatchlistQueryLinks
    on QueryBuilder<Watchlist, Watchlist, QFilterCondition> {}

extension WatchlistQuerySortBy on QueryBuilder<Watchlist, Watchlist, QSortBy> {
  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension WatchlistQuerySortThenBy
    on QueryBuilder<Watchlist, Watchlist, QSortThenBy> {
  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Watchlist, Watchlist, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension WatchlistQueryWhereDistinct
    on QueryBuilder<Watchlist, Watchlist, QDistinct> {
  QueryBuilder<Watchlist, Watchlist, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Watchlist, Watchlist, QDistinct> distinctByWatchIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchIds');
    });
  }
}

extension WatchlistQueryProperty
    on QueryBuilder<Watchlist, Watchlist, QQueryProperty> {
  QueryBuilder<Watchlist, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Watchlist, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Watchlist, List<int>, QQueryOperations> watchIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchIds');
    });
  }
}
