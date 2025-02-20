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
    r'compareResults': PropertySchema(
      id: 0,
      name: r'compareResults',
      type: IsarType.boolList,
    ),
    r'letterDraw': PropertySchema(
      id: 1,
      name: r'letterDraw',
      type: IsarType.stringList,
    ),
    r'trajectories': PropertySchema(
      id: 2,
      name: r'trajectories',
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
  bytesCount += 3 + object.compareResults.length;
  bytesCount += 3 + object.letterDraw.length * 3;
  {
    for (var i = 0; i < object.letterDraw.length; i++) {
      final value = object.letterDraw[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.trajectories.length;
  return bytesCount;
}

void _savedDataSerialize(
  SavedData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBoolList(offsets[0], object.compareResults);
  writer.writeStringList(offsets[1], object.letterDraw);
  writer.writeBoolList(offsets[2], object.trajectories);
}

SavedData _savedDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedData(
    compareResults: reader.readBoolList(offsets[0]) ?? [],
    letterDraw: reader.readStringList(offsets[1]) ?? [],
    letterIndex: id,
    trajectories: reader.readBoolList(offsets[2]) ?? [],
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
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
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
  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compareResults',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      compareResultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compareResults',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterDraw',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'letterDraw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'letterDraw',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterDraw',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'letterDraw',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      letterDrawLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'letterDraw',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

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
      trajectoriesElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trajectories',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SavedData, SavedData, QAfterFilterCondition>
      trajectoriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trajectories',
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
  QueryBuilder<SavedData, SavedData, QDistinct> distinctByCompareResults() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compareResults');
    });
  }

  QueryBuilder<SavedData, SavedData, QDistinct> distinctByLetterDraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterDraw');
    });
  }

  QueryBuilder<SavedData, SavedData, QDistinct> distinctByTrajectories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trajectories');
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

  QueryBuilder<SavedData, List<bool>, QQueryOperations>
      compareResultsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compareResults');
    });
  }

  QueryBuilder<SavedData, List<String>, QQueryOperations> letterDrawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterDraw');
    });
  }

  QueryBuilder<SavedData, List<bool>, QQueryOperations> trajectoriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trajectories');
    });
  }
}
