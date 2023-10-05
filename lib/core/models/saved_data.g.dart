// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedDataCollection on Isar {
  IsarCollection<SavedData> get savedDatas => this.collection();
}

const SavedDataSchema = CollectionSchema(
  name: r'SavedData',
  id: -6121529716315233452,
  properties: {
    r'results': PropertySchema(
      id: 0,
      name: r'results',
      type: IsarType.boolList,
    )
  },
  estimateSize: _savedDataEstimateSize,
  serialize: _savedDataSerialize,
  deserialize: _savedDataDeserialize,
  deserializeProp: _savedDataDeserializeProp,
  idName: r'letterIndex',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _savedDataGetId,
  getLinks: _savedDataGetLinks,
  attach: _savedDataAttach,
  version: '3.1.0+1',
);

int _savedDataEstimateSize(
  SavedData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.results.length;
  return bytesCount;
}

void _savedDataSerialize(
  SavedData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBoolList(offsets[0], object.results);
}

SavedData _savedDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedData(
    letterIndex: id,
    results: reader.readBoolList(offsets[0]) ?? [],
  );
  return object;
}

P _savedDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedDataGetId(SavedData object) {
  return object.letterIndex;
}

List<IsarLinkBase<dynamic>> _savedDataGetLinks(SavedData object) {
  return [];
}

void _savedDataAttach(IsarCollection<dynamic> col, Id id, SavedData object) {
  object.letterIndex = id;
}

extension SavedDataQueryWhereSort
    on QueryBuilder<SavedData, SavedData, QWhere> {
  QueryBuilder<SavedData, SavedData, QAfterWhere> anyLetterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavedDataQueryWhere
    on QueryBuilder<SavedData, SavedData, QWhereClause> {
  QueryBuilder<SavedData, SavedData, QAfterWhereClause> letterIndexEqualTo(
      Id letterIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: letterIndex,
        upper: letterIndex,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterWhereClause> letterIndexNotEqualTo(
      Id letterIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: letterIndex, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: letterIndex, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: letterIndex, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: letterIndex, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterWhereClause> letterIndexGreaterThan(
      Id letterIndex,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: letterIndex, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterWhereClause> letterIndexLessThan(
      Id letterIndex,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: letterIndex, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterWhereClause> letterIndexBetween(
    Id lowerLetterIndex,
    Id upperLetterIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLetterIndex,
        includeLower: includeLower,
        upper: upperLetterIndex,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavedDataQueryFilter
    on QueryBuilder<SavedData, SavedData, QFilterCondition> {
  QueryBuilder<SavedData, SavedData, QAfterFilterCondition> letterIndexEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterIndexGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition> letterIndexLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition> letterIndexBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'results',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition> resultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      resultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SavedDataQueryObject
    on QueryBuilder<SavedData, SavedData, QFilterCondition> {}

extension SavedDataQueryLinks
    on QueryBuilder<SavedData, SavedData, QFilterCondition> {}

extension SavedDataQuerySortBy on QueryBuilder<SavedData, SavedData, QSortBy> {}

extension SavedDataQuerySortThenBy
    on QueryBuilder<SavedData, SavedData, QSortThenBy> {
  QueryBuilder<SavedData, SavedData, QAfterSortBy> thenByLetterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterIndex', Sort.asc);
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterSortBy> thenByLetterIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterIndex', Sort.desc);
    });
  }
}

extension SavedDataQueryWhereDistinct
    on QueryBuilder<SavedData, SavedData, QDistinct> {
  QueryBuilder<SavedData, SavedData, QDistinct> distinctByResults() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'results');
    });
  }
}

extension SavedDataQueryProperty
    on QueryBuilder<SavedData, SavedData, QQueryProperty> {
  QueryBuilder<SavedData, int, QQueryOperations> letterIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterIndex');
    });
  }

  QueryBuilder<SavedData, List<bool>, QQueryOperations> resultsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'results');
    });
  }
}
