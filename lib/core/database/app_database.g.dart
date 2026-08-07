// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BatchesTable extends Batches with TableInfo<$BatchesTable, Batche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _farmerNameMeta = const VerificationMeta(
    'farmerName',
  );
  @override
  late final GeneratedColumn<String> farmerName = GeneratedColumn<String>(
    'farmer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _wasteTypeMeta = const VerificationMeta(
    'wasteType',
  );
  @override
  late final GeneratedColumn<String> wasteType = GeneratedColumn<String>(
    'waste_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mixed_waste'),
  );
  static const VerificationMeta _wasteQuantityKgMeta = const VerificationMeta(
    'wasteQuantityKg',
  );
  @override
  late final GeneratedColumn<double> wasteQuantityKg = GeneratedColumn<double>(
    'waste_quantity_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _neonatesAddedMeta = const VerificationMeta(
    'neonatesAdded',
  );
  @override
  late final GeneratedColumn<int> neonatesAdded = GeneratedColumn<int>(
    'neonates_added',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedHarvestDateMeta =
      const VerificationMeta('expectedHarvestDate');
  @override
  late final GeneratedColumn<String> expectedHarvestDate =
      GeneratedColumn<String>(
        'expected_harvest_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _actualHarvestDateMeta = const VerificationMeta(
    'actualHarvestDate',
  );
  @override
  late final GeneratedColumn<String> actualHarvestDate =
      GeneratedColumn<String>(
        'actual_harvest_date',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchNumber,
    farmerId,
    farmerName,
    wasteType,
    wasteQuantityKg,
    neonatesAdded,
    status,
    dayNumber,
    startDate,
    expectedHarvestDate,
    actualHarvestDate,
    notes,
    photoUrl,
    latitude,
    longitude,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Batche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    }
    if (data.containsKey('farmer_name')) {
      context.handle(
        _farmerNameMeta,
        farmerName.isAcceptableOrUnknown(data['farmer_name']!, _farmerNameMeta),
      );
    }
    if (data.containsKey('waste_type')) {
      context.handle(
        _wasteTypeMeta,
        wasteType.isAcceptableOrUnknown(data['waste_type']!, _wasteTypeMeta),
      );
    }
    if (data.containsKey('waste_quantity_kg')) {
      context.handle(
        _wasteQuantityKgMeta,
        wasteQuantityKg.isAcceptableOrUnknown(
          data['waste_quantity_kg']!,
          _wasteQuantityKgMeta,
        ),
      );
    }
    if (data.containsKey('neonates_added')) {
      context.handle(
        _neonatesAddedMeta,
        neonatesAdded.isAcceptableOrUnknown(
          data['neonates_added']!,
          _neonatesAddedMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('expected_harvest_date')) {
      context.handle(
        _expectedHarvestDateMeta,
        expectedHarvestDate.isAcceptableOrUnknown(
          data['expected_harvest_date']!,
          _expectedHarvestDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedHarvestDateMeta);
    }
    if (data.containsKey('actual_harvest_date')) {
      context.handle(
        _actualHarvestDateMeta,
        actualHarvestDate.isAcceptableOrUnknown(
          data['actual_harvest_date']!,
          _actualHarvestDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Batche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Batche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      farmerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_name'],
      )!,
      wasteType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waste_type'],
      )!,
      wasteQuantityKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waste_quantity_kg'],
      )!,
      neonatesAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}neonates_added'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      expectedHarvestDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_harvest_date'],
      )!,
      actualHarvestDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_harvest_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }
}

class Batche extends DataClass implements Insertable<Batche> {
  final int id;
  final String batchNumber;
  final String farmerId;
  final String farmerName;
  final String wasteType;
  final double wasteQuantityKg;
  final int neonatesAdded;
  final String status;
  final int dayNumber;
  final String startDate;
  final String expectedHarvestDate;
  final String? actualHarvestDate;
  final String? notes;
  final String? photoUrl;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Batche({
    required this.id,
    required this.batchNumber,
    required this.farmerId,
    required this.farmerName,
    required this.wasteType,
    required this.wasteQuantityKg,
    required this.neonatesAdded,
    required this.status,
    required this.dayNumber,
    required this.startDate,
    required this.expectedHarvestDate,
    this.actualHarvestDate,
    this.notes,
    this.photoUrl,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_number'] = Variable<String>(batchNumber);
    map['farmer_id'] = Variable<String>(farmerId);
    map['farmer_name'] = Variable<String>(farmerName);
    map['waste_type'] = Variable<String>(wasteType);
    map['waste_quantity_kg'] = Variable<double>(wasteQuantityKg);
    map['neonates_added'] = Variable<int>(neonatesAdded);
    map['status'] = Variable<String>(status);
    map['day_number'] = Variable<int>(dayNumber);
    map['start_date'] = Variable<String>(startDate);
    map['expected_harvest_date'] = Variable<String>(expectedHarvestDate);
    if (!nullToAbsent || actualHarvestDate != null) {
      map['actual_harvest_date'] = Variable<String>(actualHarvestDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      batchNumber: Value(batchNumber),
      farmerId: Value(farmerId),
      farmerName: Value(farmerName),
      wasteType: Value(wasteType),
      wasteQuantityKg: Value(wasteQuantityKg),
      neonatesAdded: Value(neonatesAdded),
      status: Value(status),
      dayNumber: Value(dayNumber),
      startDate: Value(startDate),
      expectedHarvestDate: Value(expectedHarvestDate),
      actualHarvestDate: actualHarvestDate == null && nullToAbsent
          ? const Value.absent()
          : Value(actualHarvestDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Batche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Batche(
      id: serializer.fromJson<int>(json['id']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      farmerName: serializer.fromJson<String>(json['farmerName']),
      wasteType: serializer.fromJson<String>(json['wasteType']),
      wasteQuantityKg: serializer.fromJson<double>(json['wasteQuantityKg']),
      neonatesAdded: serializer.fromJson<int>(json['neonatesAdded']),
      status: serializer.fromJson<String>(json['status']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      startDate: serializer.fromJson<String>(json['startDate']),
      expectedHarvestDate: serializer.fromJson<String>(
        json['expectedHarvestDate'],
      ),
      actualHarvestDate: serializer.fromJson<String?>(
        json['actualHarvestDate'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'farmerId': serializer.toJson<String>(farmerId),
      'farmerName': serializer.toJson<String>(farmerName),
      'wasteType': serializer.toJson<String>(wasteType),
      'wasteQuantityKg': serializer.toJson<double>(wasteQuantityKg),
      'neonatesAdded': serializer.toJson<int>(neonatesAdded),
      'status': serializer.toJson<String>(status),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'startDate': serializer.toJson<String>(startDate),
      'expectedHarvestDate': serializer.toJson<String>(expectedHarvestDate),
      'actualHarvestDate': serializer.toJson<String?>(actualHarvestDate),
      'notes': serializer.toJson<String?>(notes),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Batche copyWith({
    int? id,
    String? batchNumber,
    String? farmerId,
    String? farmerName,
    String? wasteType,
    double? wasteQuantityKg,
    int? neonatesAdded,
    String? status,
    int? dayNumber,
    String? startDate,
    String? expectedHarvestDate,
    Value<String?> actualHarvestDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Batche(
    id: id ?? this.id,
    batchNumber: batchNumber ?? this.batchNumber,
    farmerId: farmerId ?? this.farmerId,
    farmerName: farmerName ?? this.farmerName,
    wasteType: wasteType ?? this.wasteType,
    wasteQuantityKg: wasteQuantityKg ?? this.wasteQuantityKg,
    neonatesAdded: neonatesAdded ?? this.neonatesAdded,
    status: status ?? this.status,
    dayNumber: dayNumber ?? this.dayNumber,
    startDate: startDate ?? this.startDate,
    expectedHarvestDate: expectedHarvestDate ?? this.expectedHarvestDate,
    actualHarvestDate: actualHarvestDate.present
        ? actualHarvestDate.value
        : this.actualHarvestDate,
    notes: notes.present ? notes.value : this.notes,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Batche copyWithCompanion(BatchesCompanion data) {
    return Batche(
      id: data.id.present ? data.id.value : this.id,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      farmerName: data.farmerName.present
          ? data.farmerName.value
          : this.farmerName,
      wasteType: data.wasteType.present ? data.wasteType.value : this.wasteType,
      wasteQuantityKg: data.wasteQuantityKg.present
          ? data.wasteQuantityKg.value
          : this.wasteQuantityKg,
      neonatesAdded: data.neonatesAdded.present
          ? data.neonatesAdded.value
          : this.neonatesAdded,
      status: data.status.present ? data.status.value : this.status,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      expectedHarvestDate: data.expectedHarvestDate.present
          ? data.expectedHarvestDate.value
          : this.expectedHarvestDate,
      actualHarvestDate: data.actualHarvestDate.present
          ? data.actualHarvestDate.value
          : this.actualHarvestDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Batche(')
          ..write('id: $id, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('farmerId: $farmerId, ')
          ..write('farmerName: $farmerName, ')
          ..write('wasteType: $wasteType, ')
          ..write('wasteQuantityKg: $wasteQuantityKg, ')
          ..write('neonatesAdded: $neonatesAdded, ')
          ..write('status: $status, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('startDate: $startDate, ')
          ..write('expectedHarvestDate: $expectedHarvestDate, ')
          ..write('actualHarvestDate: $actualHarvestDate, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchNumber,
    farmerId,
    farmerName,
    wasteType,
    wasteQuantityKg,
    neonatesAdded,
    status,
    dayNumber,
    startDate,
    expectedHarvestDate,
    actualHarvestDate,
    notes,
    photoUrl,
    latitude,
    longitude,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batche &&
          other.id == this.id &&
          other.batchNumber == this.batchNumber &&
          other.farmerId == this.farmerId &&
          other.farmerName == this.farmerName &&
          other.wasteType == this.wasteType &&
          other.wasteQuantityKg == this.wasteQuantityKg &&
          other.neonatesAdded == this.neonatesAdded &&
          other.status == this.status &&
          other.dayNumber == this.dayNumber &&
          other.startDate == this.startDate &&
          other.expectedHarvestDate == this.expectedHarvestDate &&
          other.actualHarvestDate == this.actualHarvestDate &&
          other.notes == this.notes &&
          other.photoUrl == this.photoUrl &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BatchesCompanion extends UpdateCompanion<Batche> {
  final Value<int> id;
  final Value<String> batchNumber;
  final Value<String> farmerId;
  final Value<String> farmerName;
  final Value<String> wasteType;
  final Value<double> wasteQuantityKg;
  final Value<int> neonatesAdded;
  final Value<String> status;
  final Value<int> dayNumber;
  final Value<String> startDate;
  final Value<String> expectedHarvestDate;
  final Value<String?> actualHarvestDate;
  final Value<String?> notes;
  final Value<String?> photoUrl;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerName = const Value.absent(),
    this.wasteType = const Value.absent(),
    this.wasteQuantityKg = const Value.absent(),
    this.neonatesAdded = const Value.absent(),
    this.status = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.expectedHarvestDate = const Value.absent(),
    this.actualHarvestDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BatchesCompanion.insert({
    this.id = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerName = const Value.absent(),
    this.wasteType = const Value.absent(),
    this.wasteQuantityKg = const Value.absent(),
    this.neonatesAdded = const Value.absent(),
    this.status = const Value.absent(),
    this.dayNumber = const Value.absent(),
    required String startDate,
    required String expectedHarvestDate,
    this.actualHarvestDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : startDate = Value(startDate),
       expectedHarvestDate = Value(expectedHarvestDate);
  static Insertable<Batche> custom({
    Expression<int>? id,
    Expression<String>? batchNumber,
    Expression<String>? farmerId,
    Expression<String>? farmerName,
    Expression<String>? wasteType,
    Expression<double>? wasteQuantityKg,
    Expression<int>? neonatesAdded,
    Expression<String>? status,
    Expression<int>? dayNumber,
    Expression<String>? startDate,
    Expression<String>? expectedHarvestDate,
    Expression<String>? actualHarvestDate,
    Expression<String>? notes,
    Expression<String>? photoUrl,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (farmerId != null) 'farmer_id': farmerId,
      if (farmerName != null) 'farmer_name': farmerName,
      if (wasteType != null) 'waste_type': wasteType,
      if (wasteQuantityKg != null) 'waste_quantity_kg': wasteQuantityKg,
      if (neonatesAdded != null) 'neonates_added': neonatesAdded,
      if (status != null) 'status': status,
      if (dayNumber != null) 'day_number': dayNumber,
      if (startDate != null) 'start_date': startDate,
      if (expectedHarvestDate != null)
        'expected_harvest_date': expectedHarvestDate,
      if (actualHarvestDate != null) 'actual_harvest_date': actualHarvestDate,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BatchesCompanion copyWith({
    Value<int>? id,
    Value<String>? batchNumber,
    Value<String>? farmerId,
    Value<String>? farmerName,
    Value<String>? wasteType,
    Value<double>? wasteQuantityKg,
    Value<int>? neonatesAdded,
    Value<String>? status,
    Value<int>? dayNumber,
    Value<String>? startDate,
    Value<String>? expectedHarvestDate,
    Value<String?>? actualHarvestDate,
    Value<String?>? notes,
    Value<String?>? photoUrl,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BatchesCompanion(
      id: id ?? this.id,
      batchNumber: batchNumber ?? this.batchNumber,
      farmerId: farmerId ?? this.farmerId,
      farmerName: farmerName ?? this.farmerName,
      wasteType: wasteType ?? this.wasteType,
      wasteQuantityKg: wasteQuantityKg ?? this.wasteQuantityKg,
      neonatesAdded: neonatesAdded ?? this.neonatesAdded,
      status: status ?? this.status,
      dayNumber: dayNumber ?? this.dayNumber,
      startDate: startDate ?? this.startDate,
      expectedHarvestDate: expectedHarvestDate ?? this.expectedHarvestDate,
      actualHarvestDate: actualHarvestDate ?? this.actualHarvestDate,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (farmerName.present) {
      map['farmer_name'] = Variable<String>(farmerName.value);
    }
    if (wasteType.present) {
      map['waste_type'] = Variable<String>(wasteType.value);
    }
    if (wasteQuantityKg.present) {
      map['waste_quantity_kg'] = Variable<double>(wasteQuantityKg.value);
    }
    if (neonatesAdded.present) {
      map['neonates_added'] = Variable<int>(neonatesAdded.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (expectedHarvestDate.present) {
      map['expected_harvest_date'] = Variable<String>(
        expectedHarvestDate.value,
      );
    }
    if (actualHarvestDate.present) {
      map['actual_harvest_date'] = Variable<String>(actualHarvestDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('farmerId: $farmerId, ')
          ..write('farmerName: $farmerName, ')
          ..write('wasteType: $wasteType, ')
          ..write('wasteQuantityKg: $wasteQuantityKg, ')
          ..write('neonatesAdded: $neonatesAdded, ')
          ..write('status: $status, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('startDate: $startDate, ')
          ..write('expectedHarvestDate: $expectedHarvestDate, ')
          ..write('actualHarvestDate: $actualHarvestDate, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BreedingCagesTable extends BreedingCages
    with TableInfo<$BreedingCagesTable, BreedingCage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BreedingCagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cageNumberMeta = const VerificationMeta(
    'cageNumber',
  );
  @override
  late final GeneratedColumn<String> cageNumber = GeneratedColumn<String>(
    'cage_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _ageDaysMeta = const VerificationMeta(
    'ageDays',
  );
  @override
  late final GeneratedColumn<int> ageDays = GeneratedColumn<int>(
    'age_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pupaLoadedKgMeta = const VerificationMeta(
    'pupaLoadedKg',
  );
  @override
  late final GeneratedColumn<double> pupaLoadedKg = GeneratedColumn<double>(
    'pupa_loaded_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _pupaSourceMeta = const VerificationMeta(
    'pupaSource',
  );
  @override
  late final GeneratedColumn<String> pupaSource = GeneratedColumn<String>(
    'pupa_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breedingDateMeta = const VerificationMeta(
    'breedingDate',
  );
  @override
  late final GeneratedColumn<DateTime> breedingDate = GeneratedColumn<DateTime>(
    'breeding_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMaintenanceDateMeta =
      const VerificationMeta('lastMaintenanceDate');
  @override
  late final GeneratedColumn<DateTime> lastMaintenanceDate =
      GeneratedColumn<DateTime>(
        'last_maintenance_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _attractantInstalledMeta =
      const VerificationMeta('attractantInstalled');
  @override
  late final GeneratedColumn<bool> attractantInstalled = GeneratedColumn<bool>(
    'attractant_installed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("attractant_installed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _waterAddedMeta = const VerificationMeta(
    'waterAdded',
  );
  @override
  late final GeneratedColumn<bool> waterAdded = GeneratedColumn<bool>(
    'water_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("water_added" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cageNumber,
    farmerId,
    status,
    ageDays,
    pupaLoadedKg,
    pupaSource,
    breedingDate,
    lastMaintenanceDate,
    attractantInstalled,
    waterAdded,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'breeding_cages';
  @override
  VerificationContext validateIntegrity(
    Insertable<BreedingCage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cage_number')) {
      context.handle(
        _cageNumberMeta,
        cageNumber.isAcceptableOrUnknown(data['cage_number']!, _cageNumberMeta),
      );
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('age_days')) {
      context.handle(
        _ageDaysMeta,
        ageDays.isAcceptableOrUnknown(data['age_days']!, _ageDaysMeta),
      );
    }
    if (data.containsKey('pupa_loaded_kg')) {
      context.handle(
        _pupaLoadedKgMeta,
        pupaLoadedKg.isAcceptableOrUnknown(
          data['pupa_loaded_kg']!,
          _pupaLoadedKgMeta,
        ),
      );
    }
    if (data.containsKey('pupa_source')) {
      context.handle(
        _pupaSourceMeta,
        pupaSource.isAcceptableOrUnknown(data['pupa_source']!, _pupaSourceMeta),
      );
    }
    if (data.containsKey('breeding_date')) {
      context.handle(
        _breedingDateMeta,
        breedingDate.isAcceptableOrUnknown(
          data['breeding_date']!,
          _breedingDateMeta,
        ),
      );
    }
    if (data.containsKey('last_maintenance_date')) {
      context.handle(
        _lastMaintenanceDateMeta,
        lastMaintenanceDate.isAcceptableOrUnknown(
          data['last_maintenance_date']!,
          _lastMaintenanceDateMeta,
        ),
      );
    }
    if (data.containsKey('attractant_installed')) {
      context.handle(
        _attractantInstalledMeta,
        attractantInstalled.isAcceptableOrUnknown(
          data['attractant_installed']!,
          _attractantInstalledMeta,
        ),
      );
    }
    if (data.containsKey('water_added')) {
      context.handle(
        _waterAddedMeta,
        waterAdded.isAcceptableOrUnknown(data['water_added']!, _waterAddedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BreedingCage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BreedingCage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cage_number'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      ageDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age_days'],
      )!,
      pupaLoadedKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pupa_loaded_kg'],
      )!,
      pupaSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pupa_source'],
      ),
      breedingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}breeding_date'],
      ),
      lastMaintenanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_maintenance_date'],
      ),
      attractantInstalled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}attractant_installed'],
      )!,
      waterAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}water_added'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BreedingCagesTable createAlias(String alias) {
    return $BreedingCagesTable(attachedDatabase, alias);
  }
}

class BreedingCage extends DataClass implements Insertable<BreedingCage> {
  final int id;
  final String cageNumber;
  final String farmerId;
  final String status;
  final int ageDays;
  final double pupaLoadedKg;
  final String? pupaSource;
  final DateTime? breedingDate;
  final DateTime? lastMaintenanceDate;
  final bool attractantInstalled;
  final bool waterAdded;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BreedingCage({
    required this.id,
    required this.cageNumber,
    required this.farmerId,
    required this.status,
    required this.ageDays,
    required this.pupaLoadedKg,
    this.pupaSource,
    this.breedingDate,
    this.lastMaintenanceDate,
    required this.attractantInstalled,
    required this.waterAdded,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cage_number'] = Variable<String>(cageNumber);
    map['farmer_id'] = Variable<String>(farmerId);
    map['status'] = Variable<String>(status);
    map['age_days'] = Variable<int>(ageDays);
    map['pupa_loaded_kg'] = Variable<double>(pupaLoadedKg);
    if (!nullToAbsent || pupaSource != null) {
      map['pupa_source'] = Variable<String>(pupaSource);
    }
    if (!nullToAbsent || breedingDate != null) {
      map['breeding_date'] = Variable<DateTime>(breedingDate);
    }
    if (!nullToAbsent || lastMaintenanceDate != null) {
      map['last_maintenance_date'] = Variable<DateTime>(lastMaintenanceDate);
    }
    map['attractant_installed'] = Variable<bool>(attractantInstalled);
    map['water_added'] = Variable<bool>(waterAdded);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BreedingCagesCompanion toCompanion(bool nullToAbsent) {
    return BreedingCagesCompanion(
      id: Value(id),
      cageNumber: Value(cageNumber),
      farmerId: Value(farmerId),
      status: Value(status),
      ageDays: Value(ageDays),
      pupaLoadedKg: Value(pupaLoadedKg),
      pupaSource: pupaSource == null && nullToAbsent
          ? const Value.absent()
          : Value(pupaSource),
      breedingDate: breedingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(breedingDate),
      lastMaintenanceDate: lastMaintenanceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMaintenanceDate),
      attractantInstalled: Value(attractantInstalled),
      waterAdded: Value(waterAdded),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BreedingCage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BreedingCage(
      id: serializer.fromJson<int>(json['id']),
      cageNumber: serializer.fromJson<String>(json['cageNumber']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      status: serializer.fromJson<String>(json['status']),
      ageDays: serializer.fromJson<int>(json['ageDays']),
      pupaLoadedKg: serializer.fromJson<double>(json['pupaLoadedKg']),
      pupaSource: serializer.fromJson<String?>(json['pupaSource']),
      breedingDate: serializer.fromJson<DateTime?>(json['breedingDate']),
      lastMaintenanceDate: serializer.fromJson<DateTime?>(
        json['lastMaintenanceDate'],
      ),
      attractantInstalled: serializer.fromJson<bool>(
        json['attractantInstalled'],
      ),
      waterAdded: serializer.fromJson<bool>(json['waterAdded']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cageNumber': serializer.toJson<String>(cageNumber),
      'farmerId': serializer.toJson<String>(farmerId),
      'status': serializer.toJson<String>(status),
      'ageDays': serializer.toJson<int>(ageDays),
      'pupaLoadedKg': serializer.toJson<double>(pupaLoadedKg),
      'pupaSource': serializer.toJson<String?>(pupaSource),
      'breedingDate': serializer.toJson<DateTime?>(breedingDate),
      'lastMaintenanceDate': serializer.toJson<DateTime?>(lastMaintenanceDate),
      'attractantInstalled': serializer.toJson<bool>(attractantInstalled),
      'waterAdded': serializer.toJson<bool>(waterAdded),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BreedingCage copyWith({
    int? id,
    String? cageNumber,
    String? farmerId,
    String? status,
    int? ageDays,
    double? pupaLoadedKg,
    Value<String?> pupaSource = const Value.absent(),
    Value<DateTime?> breedingDate = const Value.absent(),
    Value<DateTime?> lastMaintenanceDate = const Value.absent(),
    bool? attractantInstalled,
    bool? waterAdded,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BreedingCage(
    id: id ?? this.id,
    cageNumber: cageNumber ?? this.cageNumber,
    farmerId: farmerId ?? this.farmerId,
    status: status ?? this.status,
    ageDays: ageDays ?? this.ageDays,
    pupaLoadedKg: pupaLoadedKg ?? this.pupaLoadedKg,
    pupaSource: pupaSource.present ? pupaSource.value : this.pupaSource,
    breedingDate: breedingDate.present ? breedingDate.value : this.breedingDate,
    lastMaintenanceDate: lastMaintenanceDate.present
        ? lastMaintenanceDate.value
        : this.lastMaintenanceDate,
    attractantInstalled: attractantInstalled ?? this.attractantInstalled,
    waterAdded: waterAdded ?? this.waterAdded,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BreedingCage copyWithCompanion(BreedingCagesCompanion data) {
    return BreedingCage(
      id: data.id.present ? data.id.value : this.id,
      cageNumber: data.cageNumber.present
          ? data.cageNumber.value
          : this.cageNumber,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      status: data.status.present ? data.status.value : this.status,
      ageDays: data.ageDays.present ? data.ageDays.value : this.ageDays,
      pupaLoadedKg: data.pupaLoadedKg.present
          ? data.pupaLoadedKg.value
          : this.pupaLoadedKg,
      pupaSource: data.pupaSource.present
          ? data.pupaSource.value
          : this.pupaSource,
      breedingDate: data.breedingDate.present
          ? data.breedingDate.value
          : this.breedingDate,
      lastMaintenanceDate: data.lastMaintenanceDate.present
          ? data.lastMaintenanceDate.value
          : this.lastMaintenanceDate,
      attractantInstalled: data.attractantInstalled.present
          ? data.attractantInstalled.value
          : this.attractantInstalled,
      waterAdded: data.waterAdded.present
          ? data.waterAdded.value
          : this.waterAdded,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BreedingCage(')
          ..write('id: $id, ')
          ..write('cageNumber: $cageNumber, ')
          ..write('farmerId: $farmerId, ')
          ..write('status: $status, ')
          ..write('ageDays: $ageDays, ')
          ..write('pupaLoadedKg: $pupaLoadedKg, ')
          ..write('pupaSource: $pupaSource, ')
          ..write('breedingDate: $breedingDate, ')
          ..write('lastMaintenanceDate: $lastMaintenanceDate, ')
          ..write('attractantInstalled: $attractantInstalled, ')
          ..write('waterAdded: $waterAdded, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cageNumber,
    farmerId,
    status,
    ageDays,
    pupaLoadedKg,
    pupaSource,
    breedingDate,
    lastMaintenanceDate,
    attractantInstalled,
    waterAdded,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BreedingCage &&
          other.id == this.id &&
          other.cageNumber == this.cageNumber &&
          other.farmerId == this.farmerId &&
          other.status == this.status &&
          other.ageDays == this.ageDays &&
          other.pupaLoadedKg == this.pupaLoadedKg &&
          other.pupaSource == this.pupaSource &&
          other.breedingDate == this.breedingDate &&
          other.lastMaintenanceDate == this.lastMaintenanceDate &&
          other.attractantInstalled == this.attractantInstalled &&
          other.waterAdded == this.waterAdded &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BreedingCagesCompanion extends UpdateCompanion<BreedingCage> {
  final Value<int> id;
  final Value<String> cageNumber;
  final Value<String> farmerId;
  final Value<String> status;
  final Value<int> ageDays;
  final Value<double> pupaLoadedKg;
  final Value<String?> pupaSource;
  final Value<DateTime?> breedingDate;
  final Value<DateTime?> lastMaintenanceDate;
  final Value<bool> attractantInstalled;
  final Value<bool> waterAdded;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BreedingCagesCompanion({
    this.id = const Value.absent(),
    this.cageNumber = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.status = const Value.absent(),
    this.ageDays = const Value.absent(),
    this.pupaLoadedKg = const Value.absent(),
    this.pupaSource = const Value.absent(),
    this.breedingDate = const Value.absent(),
    this.lastMaintenanceDate = const Value.absent(),
    this.attractantInstalled = const Value.absent(),
    this.waterAdded = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BreedingCagesCompanion.insert({
    this.id = const Value.absent(),
    this.cageNumber = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.status = const Value.absent(),
    this.ageDays = const Value.absent(),
    this.pupaLoadedKg = const Value.absent(),
    this.pupaSource = const Value.absent(),
    this.breedingDate = const Value.absent(),
    this.lastMaintenanceDate = const Value.absent(),
    this.attractantInstalled = const Value.absent(),
    this.waterAdded = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<BreedingCage> custom({
    Expression<int>? id,
    Expression<String>? cageNumber,
    Expression<String>? farmerId,
    Expression<String>? status,
    Expression<int>? ageDays,
    Expression<double>? pupaLoadedKg,
    Expression<String>? pupaSource,
    Expression<DateTime>? breedingDate,
    Expression<DateTime>? lastMaintenanceDate,
    Expression<bool>? attractantInstalled,
    Expression<bool>? waterAdded,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cageNumber != null) 'cage_number': cageNumber,
      if (farmerId != null) 'farmer_id': farmerId,
      if (status != null) 'status': status,
      if (ageDays != null) 'age_days': ageDays,
      if (pupaLoadedKg != null) 'pupa_loaded_kg': pupaLoadedKg,
      if (pupaSource != null) 'pupa_source': pupaSource,
      if (breedingDate != null) 'breeding_date': breedingDate,
      if (lastMaintenanceDate != null)
        'last_maintenance_date': lastMaintenanceDate,
      if (attractantInstalled != null)
        'attractant_installed': attractantInstalled,
      if (waterAdded != null) 'water_added': waterAdded,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BreedingCagesCompanion copyWith({
    Value<int>? id,
    Value<String>? cageNumber,
    Value<String>? farmerId,
    Value<String>? status,
    Value<int>? ageDays,
    Value<double>? pupaLoadedKg,
    Value<String?>? pupaSource,
    Value<DateTime?>? breedingDate,
    Value<DateTime?>? lastMaintenanceDate,
    Value<bool>? attractantInstalled,
    Value<bool>? waterAdded,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BreedingCagesCompanion(
      id: id ?? this.id,
      cageNumber: cageNumber ?? this.cageNumber,
      farmerId: farmerId ?? this.farmerId,
      status: status ?? this.status,
      ageDays: ageDays ?? this.ageDays,
      pupaLoadedKg: pupaLoadedKg ?? this.pupaLoadedKg,
      pupaSource: pupaSource ?? this.pupaSource,
      breedingDate: breedingDate ?? this.breedingDate,
      lastMaintenanceDate: lastMaintenanceDate ?? this.lastMaintenanceDate,
      attractantInstalled: attractantInstalled ?? this.attractantInstalled,
      waterAdded: waterAdded ?? this.waterAdded,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cageNumber.present) {
      map['cage_number'] = Variable<String>(cageNumber.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (ageDays.present) {
      map['age_days'] = Variable<int>(ageDays.value);
    }
    if (pupaLoadedKg.present) {
      map['pupa_loaded_kg'] = Variable<double>(pupaLoadedKg.value);
    }
    if (pupaSource.present) {
      map['pupa_source'] = Variable<String>(pupaSource.value);
    }
    if (breedingDate.present) {
      map['breeding_date'] = Variable<DateTime>(breedingDate.value);
    }
    if (lastMaintenanceDate.present) {
      map['last_maintenance_date'] = Variable<DateTime>(
        lastMaintenanceDate.value,
      );
    }
    if (attractantInstalled.present) {
      map['attractant_installed'] = Variable<bool>(attractantInstalled.value);
    }
    if (waterAdded.present) {
      map['water_added'] = Variable<bool>(waterAdded.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreedingCagesCompanion(')
          ..write('id: $id, ')
          ..write('cageNumber: $cageNumber, ')
          ..write('farmerId: $farmerId, ')
          ..write('status: $status, ')
          ..write('ageDays: $ageDays, ')
          ..write('pupaLoadedKg: $pupaLoadedKg, ')
          ..write('pupaSource: $pupaSource, ')
          ..write('breedingDate: $breedingDate, ')
          ..write('lastMaintenanceDate: $lastMaintenanceDate, ')
          ..write('attractantInstalled: $attractantInstalled, ')
          ..write('waterAdded: $waterAdded, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FeedingsTable extends Feedings with TableInfo<$FeedingsTable, Feeding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteQuantityKgMeta = const VerificationMeta(
    'wasteQuantityKg',
  );
  @override
  late final GeneratedColumn<double> wasteQuantityKg = GeneratedColumn<double>(
    'waste_quantity_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteTypeMeta = const VerificationMeta(
    'wasteType',
  );
  @override
  late final GeneratedColumn<String> wasteType = GeneratedColumn<String>(
    'waste_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fedAtMeta = const VerificationMeta('fedAt');
  @override
  late final GeneratedColumn<DateTime> fedAt = GeneratedColumn<DateTime>(
    'fed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    wasteQuantityKg,
    wasteType,
    fedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Feeding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('waste_quantity_kg')) {
      context.handle(
        _wasteQuantityKgMeta,
        wasteQuantityKg.isAcceptableOrUnknown(
          data['waste_quantity_kg']!,
          _wasteQuantityKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wasteQuantityKgMeta);
    }
    if (data.containsKey('waste_type')) {
      context.handle(
        _wasteTypeMeta,
        wasteType.isAcceptableOrUnknown(data['waste_type']!, _wasteTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_wasteTypeMeta);
    }
    if (data.containsKey('fed_at')) {
      context.handle(
        _fedAtMeta,
        fedAt.isAcceptableOrUnknown(data['fed_at']!, _fedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feeding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feeding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      wasteQuantityKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waste_quantity_kg'],
      )!,
      wasteType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waste_type'],
      )!,
      fedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fed_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FeedingsTable createAlias(String alias) {
    return $FeedingsTable(attachedDatabase, alias);
  }
}

class Feeding extends DataClass implements Insertable<Feeding> {
  final int id;
  final String batchId;
  final double wasteQuantityKg;
  final String wasteType;
  final DateTime fedAt;
  final String? notes;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Feeding({
    required this.id,
    required this.batchId,
    required this.wasteQuantityKg,
    required this.wasteType,
    required this.fedAt,
    this.notes,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['waste_quantity_kg'] = Variable<double>(wasteQuantityKg);
    map['waste_type'] = Variable<String>(wasteType);
    map['fed_at'] = Variable<DateTime>(fedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FeedingsCompanion toCompanion(bool nullToAbsent) {
    return FeedingsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      wasteQuantityKg: Value(wasteQuantityKg),
      wasteType: Value(wasteType),
      fedAt: Value(fedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Feeding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feeding(
      id: serializer.fromJson<int>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      wasteQuantityKg: serializer.fromJson<double>(json['wasteQuantityKg']),
      wasteType: serializer.fromJson<String>(json['wasteType']),
      fedAt: serializer.fromJson<DateTime>(json['fedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchId': serializer.toJson<String>(batchId),
      'wasteQuantityKg': serializer.toJson<double>(wasteQuantityKg),
      'wasteType': serializer.toJson<String>(wasteType),
      'fedAt': serializer.toJson<DateTime>(fedAt),
      'notes': serializer.toJson<String?>(notes),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Feeding copyWith({
    int? id,
    String? batchId,
    double? wasteQuantityKg,
    String? wasteType,
    DateTime? fedAt,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Feeding(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    wasteQuantityKg: wasteQuantityKg ?? this.wasteQuantityKg,
    wasteType: wasteType ?? this.wasteType,
    fedAt: fedAt ?? this.fedAt,
    notes: notes.present ? notes.value : this.notes,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Feeding copyWithCompanion(FeedingsCompanion data) {
    return Feeding(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      wasteQuantityKg: data.wasteQuantityKg.present
          ? data.wasteQuantityKg.value
          : this.wasteQuantityKg,
      wasteType: data.wasteType.present ? data.wasteType.value : this.wasteType,
      fedAt: data.fedAt.present ? data.fedAt.value : this.fedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feeding(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('wasteQuantityKg: $wasteQuantityKg, ')
          ..write('wasteType: $wasteType, ')
          ..write('fedAt: $fedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    wasteQuantityKg,
    wasteType,
    fedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feeding &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.wasteQuantityKg == this.wasteQuantityKg &&
          other.wasteType == this.wasteType &&
          other.fedAt == this.fedAt &&
          other.notes == this.notes &&
          other.photoUrl == this.photoUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FeedingsCompanion extends UpdateCompanion<Feeding> {
  final Value<int> id;
  final Value<String> batchId;
  final Value<double> wasteQuantityKg;
  final Value<String> wasteType;
  final Value<DateTime> fedAt;
  final Value<String?> notes;
  final Value<String?> photoUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FeedingsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.wasteQuantityKg = const Value.absent(),
    this.wasteType = const Value.absent(),
    this.fedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FeedingsCompanion.insert({
    this.id = const Value.absent(),
    required String batchId,
    required double wasteQuantityKg,
    required String wasteType,
    required DateTime fedAt,
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : batchId = Value(batchId),
       wasteQuantityKg = Value(wasteQuantityKg),
       wasteType = Value(wasteType),
       fedAt = Value(fedAt);
  static Insertable<Feeding> custom({
    Expression<int>? id,
    Expression<String>? batchId,
    Expression<double>? wasteQuantityKg,
    Expression<String>? wasteType,
    Expression<DateTime>? fedAt,
    Expression<String>? notes,
    Expression<String>? photoUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (wasteQuantityKg != null) 'waste_quantity_kg': wasteQuantityKg,
      if (wasteType != null) 'waste_type': wasteType,
      if (fedAt != null) 'fed_at': fedAt,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FeedingsCompanion copyWith({
    Value<int>? id,
    Value<String>? batchId,
    Value<double>? wasteQuantityKg,
    Value<String>? wasteType,
    Value<DateTime>? fedAt,
    Value<String?>? notes,
    Value<String?>? photoUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FeedingsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      wasteQuantityKg: wasteQuantityKg ?? this.wasteQuantityKg,
      wasteType: wasteType ?? this.wasteType,
      fedAt: fedAt ?? this.fedAt,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (wasteQuantityKg.present) {
      map['waste_quantity_kg'] = Variable<double>(wasteQuantityKg.value);
    }
    if (wasteType.present) {
      map['waste_type'] = Variable<String>(wasteType.value);
    }
    if (fedAt.present) {
      map['fed_at'] = Variable<DateTime>(fedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('wasteQuantityKg: $wasteQuantityKg, ')
          ..write('wasteType: $wasteType, ')
          ..write('fedAt: $fedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HarvestsTable extends Harvests with TableInfo<$HarvestsTable, Harvest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HarvestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wetLarvaeKgMeta = const VerificationMeta(
    'wetLarvaeKg',
  );
  @override
  late final GeneratedColumn<double> wetLarvaeKg = GeneratedColumn<double>(
    'wet_larvae_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frassKgMeta = const VerificationMeta(
    'frassKg',
  );
  @override
  late final GeneratedColumn<double> frassKg = GeneratedColumn<double>(
    'frass_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pupaKgMeta = const VerificationMeta('pupaKg');
  @override
  late final GeneratedColumn<double> pupaKg = GeneratedColumn<double>(
    'pupa_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _harvestedAtMeta = const VerificationMeta(
    'harvestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> harvestedAt = GeneratedColumn<DateTime>(
    'harvested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    wetLarvaeKg,
    frassKg,
    pupaKg,
    harvestedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'harvests';
  @override
  VerificationContext validateIntegrity(
    Insertable<Harvest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('wet_larvae_kg')) {
      context.handle(
        _wetLarvaeKgMeta,
        wetLarvaeKg.isAcceptableOrUnknown(
          data['wet_larvae_kg']!,
          _wetLarvaeKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wetLarvaeKgMeta);
    }
    if (data.containsKey('frass_kg')) {
      context.handle(
        _frassKgMeta,
        frassKg.isAcceptableOrUnknown(data['frass_kg']!, _frassKgMeta),
      );
    }
    if (data.containsKey('pupa_kg')) {
      context.handle(
        _pupaKgMeta,
        pupaKg.isAcceptableOrUnknown(data['pupa_kg']!, _pupaKgMeta),
      );
    }
    if (data.containsKey('harvested_at')) {
      context.handle(
        _harvestedAtMeta,
        harvestedAt.isAcceptableOrUnknown(
          data['harvested_at']!,
          _harvestedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_harvestedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Harvest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Harvest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      wetLarvaeKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wet_larvae_kg'],
      )!,
      frassKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}frass_kg'],
      ),
      pupaKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pupa_kg'],
      ),
      harvestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}harvested_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HarvestsTable createAlias(String alias) {
    return $HarvestsTable(attachedDatabase, alias);
  }
}

class Harvest extends DataClass implements Insertable<Harvest> {
  final int id;
  final String batchId;
  final double wetLarvaeKg;
  final double? frassKg;
  final double? pupaKg;
  final DateTime harvestedAt;
  final String? notes;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Harvest({
    required this.id,
    required this.batchId,
    required this.wetLarvaeKg,
    this.frassKg,
    this.pupaKg,
    required this.harvestedAt,
    this.notes,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['wet_larvae_kg'] = Variable<double>(wetLarvaeKg);
    if (!nullToAbsent || frassKg != null) {
      map['frass_kg'] = Variable<double>(frassKg);
    }
    if (!nullToAbsent || pupaKg != null) {
      map['pupa_kg'] = Variable<double>(pupaKg);
    }
    map['harvested_at'] = Variable<DateTime>(harvestedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HarvestsCompanion toCompanion(bool nullToAbsent) {
    return HarvestsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      wetLarvaeKg: Value(wetLarvaeKg),
      frassKg: frassKg == null && nullToAbsent
          ? const Value.absent()
          : Value(frassKg),
      pupaKg: pupaKg == null && nullToAbsent
          ? const Value.absent()
          : Value(pupaKg),
      harvestedAt: Value(harvestedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Harvest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Harvest(
      id: serializer.fromJson<int>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      wetLarvaeKg: serializer.fromJson<double>(json['wetLarvaeKg']),
      frassKg: serializer.fromJson<double?>(json['frassKg']),
      pupaKg: serializer.fromJson<double?>(json['pupaKg']),
      harvestedAt: serializer.fromJson<DateTime>(json['harvestedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchId': serializer.toJson<String>(batchId),
      'wetLarvaeKg': serializer.toJson<double>(wetLarvaeKg),
      'frassKg': serializer.toJson<double?>(frassKg),
      'pupaKg': serializer.toJson<double?>(pupaKg),
      'harvestedAt': serializer.toJson<DateTime>(harvestedAt),
      'notes': serializer.toJson<String?>(notes),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Harvest copyWith({
    int? id,
    String? batchId,
    double? wetLarvaeKg,
    Value<double?> frassKg = const Value.absent(),
    Value<double?> pupaKg = const Value.absent(),
    DateTime? harvestedAt,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Harvest(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    wetLarvaeKg: wetLarvaeKg ?? this.wetLarvaeKg,
    frassKg: frassKg.present ? frassKg.value : this.frassKg,
    pupaKg: pupaKg.present ? pupaKg.value : this.pupaKg,
    harvestedAt: harvestedAt ?? this.harvestedAt,
    notes: notes.present ? notes.value : this.notes,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Harvest copyWithCompanion(HarvestsCompanion data) {
    return Harvest(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      wetLarvaeKg: data.wetLarvaeKg.present
          ? data.wetLarvaeKg.value
          : this.wetLarvaeKg,
      frassKg: data.frassKg.present ? data.frassKg.value : this.frassKg,
      pupaKg: data.pupaKg.present ? data.pupaKg.value : this.pupaKg,
      harvestedAt: data.harvestedAt.present
          ? data.harvestedAt.value
          : this.harvestedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Harvest(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('wetLarvaeKg: $wetLarvaeKg, ')
          ..write('frassKg: $frassKg, ')
          ..write('pupaKg: $pupaKg, ')
          ..write('harvestedAt: $harvestedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    wetLarvaeKg,
    frassKg,
    pupaKg,
    harvestedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Harvest &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.wetLarvaeKg == this.wetLarvaeKg &&
          other.frassKg == this.frassKg &&
          other.pupaKg == this.pupaKg &&
          other.harvestedAt == this.harvestedAt &&
          other.notes == this.notes &&
          other.photoUrl == this.photoUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HarvestsCompanion extends UpdateCompanion<Harvest> {
  final Value<int> id;
  final Value<String> batchId;
  final Value<double> wetLarvaeKg;
  final Value<double?> frassKg;
  final Value<double?> pupaKg;
  final Value<DateTime> harvestedAt;
  final Value<String?> notes;
  final Value<String?> photoUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HarvestsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.wetLarvaeKg = const Value.absent(),
    this.frassKg = const Value.absent(),
    this.pupaKg = const Value.absent(),
    this.harvestedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HarvestsCompanion.insert({
    this.id = const Value.absent(),
    required String batchId,
    required double wetLarvaeKg,
    this.frassKg = const Value.absent(),
    this.pupaKg = const Value.absent(),
    required DateTime harvestedAt,
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : batchId = Value(batchId),
       wetLarvaeKg = Value(wetLarvaeKg),
       harvestedAt = Value(harvestedAt);
  static Insertable<Harvest> custom({
    Expression<int>? id,
    Expression<String>? batchId,
    Expression<double>? wetLarvaeKg,
    Expression<double>? frassKg,
    Expression<double>? pupaKg,
    Expression<DateTime>? harvestedAt,
    Expression<String>? notes,
    Expression<String>? photoUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (wetLarvaeKg != null) 'wet_larvae_kg': wetLarvaeKg,
      if (frassKg != null) 'frass_kg': frassKg,
      if (pupaKg != null) 'pupa_kg': pupaKg,
      if (harvestedAt != null) 'harvested_at': harvestedAt,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HarvestsCompanion copyWith({
    Value<int>? id,
    Value<String>? batchId,
    Value<double>? wetLarvaeKg,
    Value<double?>? frassKg,
    Value<double?>? pupaKg,
    Value<DateTime>? harvestedAt,
    Value<String?>? notes,
    Value<String?>? photoUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return HarvestsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      wetLarvaeKg: wetLarvaeKg ?? this.wetLarvaeKg,
      frassKg: frassKg ?? this.frassKg,
      pupaKg: pupaKg ?? this.pupaKg,
      harvestedAt: harvestedAt ?? this.harvestedAt,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (wetLarvaeKg.present) {
      map['wet_larvae_kg'] = Variable<double>(wetLarvaeKg.value);
    }
    if (frassKg.present) {
      map['frass_kg'] = Variable<double>(frassKg.value);
    }
    if (pupaKg.present) {
      map['pupa_kg'] = Variable<double>(pupaKg.value);
    }
    if (harvestedAt.present) {
      map['harvested_at'] = Variable<DateTime>(harvestedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HarvestsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('wetLarvaeKg: $wetLarvaeKg, ')
          ..write('frassKg: $frassKg, ')
          ..write('pupaKg: $pupaKg, ')
          ..write('harvestedAt: $harvestedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EggCollectionsTable extends EggCollections
    with TableInfo<$EggCollectionsTable, EggCollection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EggCollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cageIdMeta = const VerificationMeta('cageId');
  @override
  late final GeneratedColumn<String> cageId = GeneratedColumn<String>(
    'cage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eggWeightGramsMeta = const VerificationMeta(
    'eggWeightGrams',
  );
  @override
  late final GeneratedColumn<String> eggWeightGrams = GeneratedColumn<String>(
    'egg_weight_grams',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('good'),
  );
  static const VerificationMeta _collectedAtMeta = const VerificationMeta(
    'collectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> collectedAt = GeneratedColumn<DateTime>(
    'collected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cageId,
    eggWeightGrams,
    quality,
    collectedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'egg_collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<EggCollection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cage_id')) {
      context.handle(
        _cageIdMeta,
        cageId.isAcceptableOrUnknown(data['cage_id']!, _cageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cageIdMeta);
    }
    if (data.containsKey('egg_weight_grams')) {
      context.handle(
        _eggWeightGramsMeta,
        eggWeightGrams.isAcceptableOrUnknown(
          data['egg_weight_grams']!,
          _eggWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('collected_at')) {
      context.handle(
        _collectedAtMeta,
        collectedAt.isAcceptableOrUnknown(
          data['collected_at']!,
          _collectedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EggCollection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EggCollection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cage_id'],
      )!,
      eggWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}egg_weight_grams'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      collectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}collected_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EggCollectionsTable createAlias(String alias) {
    return $EggCollectionsTable(attachedDatabase, alias);
  }
}

class EggCollection extends DataClass implements Insertable<EggCollection> {
  final int id;
  final String cageId;
  final String eggWeightGrams;
  final String quality;
  final DateTime collectedAt;
  final String? notes;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EggCollection({
    required this.id,
    required this.cageId,
    required this.eggWeightGrams,
    required this.quality,
    required this.collectedAt,
    this.notes,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cage_id'] = Variable<String>(cageId);
    map['egg_weight_grams'] = Variable<String>(eggWeightGrams);
    map['quality'] = Variable<String>(quality);
    map['collected_at'] = Variable<DateTime>(collectedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EggCollectionsCompanion toCompanion(bool nullToAbsent) {
    return EggCollectionsCompanion(
      id: Value(id),
      cageId: Value(cageId),
      eggWeightGrams: Value(eggWeightGrams),
      quality: Value(quality),
      collectedAt: Value(collectedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EggCollection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EggCollection(
      id: serializer.fromJson<int>(json['id']),
      cageId: serializer.fromJson<String>(json['cageId']),
      eggWeightGrams: serializer.fromJson<String>(json['eggWeightGrams']),
      quality: serializer.fromJson<String>(json['quality']),
      collectedAt: serializer.fromJson<DateTime>(json['collectedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cageId': serializer.toJson<String>(cageId),
      'eggWeightGrams': serializer.toJson<String>(eggWeightGrams),
      'quality': serializer.toJson<String>(quality),
      'collectedAt': serializer.toJson<DateTime>(collectedAt),
      'notes': serializer.toJson<String?>(notes),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EggCollection copyWith({
    int? id,
    String? cageId,
    String? eggWeightGrams,
    String? quality,
    DateTime? collectedAt,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EggCollection(
    id: id ?? this.id,
    cageId: cageId ?? this.cageId,
    eggWeightGrams: eggWeightGrams ?? this.eggWeightGrams,
    quality: quality ?? this.quality,
    collectedAt: collectedAt ?? this.collectedAt,
    notes: notes.present ? notes.value : this.notes,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EggCollection copyWithCompanion(EggCollectionsCompanion data) {
    return EggCollection(
      id: data.id.present ? data.id.value : this.id,
      cageId: data.cageId.present ? data.cageId.value : this.cageId,
      eggWeightGrams: data.eggWeightGrams.present
          ? data.eggWeightGrams.value
          : this.eggWeightGrams,
      quality: data.quality.present ? data.quality.value : this.quality,
      collectedAt: data.collectedAt.present
          ? data.collectedAt.value
          : this.collectedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EggCollection(')
          ..write('id: $id, ')
          ..write('cageId: $cageId, ')
          ..write('eggWeightGrams: $eggWeightGrams, ')
          ..write('quality: $quality, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cageId,
    eggWeightGrams,
    quality,
    collectedAt,
    notes,
    photoUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EggCollection &&
          other.id == this.id &&
          other.cageId == this.cageId &&
          other.eggWeightGrams == this.eggWeightGrams &&
          other.quality == this.quality &&
          other.collectedAt == this.collectedAt &&
          other.notes == this.notes &&
          other.photoUrl == this.photoUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EggCollectionsCompanion extends UpdateCompanion<EggCollection> {
  final Value<int> id;
  final Value<String> cageId;
  final Value<String> eggWeightGrams;
  final Value<String> quality;
  final Value<DateTime> collectedAt;
  final Value<String?> notes;
  final Value<String?> photoUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EggCollectionsCompanion({
    this.id = const Value.absent(),
    this.cageId = const Value.absent(),
    this.eggWeightGrams = const Value.absent(),
    this.quality = const Value.absent(),
    this.collectedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EggCollectionsCompanion.insert({
    this.id = const Value.absent(),
    required String cageId,
    this.eggWeightGrams = const Value.absent(),
    this.quality = const Value.absent(),
    required DateTime collectedAt,
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : cageId = Value(cageId),
       collectedAt = Value(collectedAt);
  static Insertable<EggCollection> custom({
    Expression<int>? id,
    Expression<String>? cageId,
    Expression<String>? eggWeightGrams,
    Expression<String>? quality,
    Expression<DateTime>? collectedAt,
    Expression<String>? notes,
    Expression<String>? photoUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cageId != null) 'cage_id': cageId,
      if (eggWeightGrams != null) 'egg_weight_grams': eggWeightGrams,
      if (quality != null) 'quality': quality,
      if (collectedAt != null) 'collected_at': collectedAt,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EggCollectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? cageId,
    Value<String>? eggWeightGrams,
    Value<String>? quality,
    Value<DateTime>? collectedAt,
    Value<String?>? notes,
    Value<String?>? photoUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EggCollectionsCompanion(
      id: id ?? this.id,
      cageId: cageId ?? this.cageId,
      eggWeightGrams: eggWeightGrams ?? this.eggWeightGrams,
      quality: quality ?? this.quality,
      collectedAt: collectedAt ?? this.collectedAt,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cageId.present) {
      map['cage_id'] = Variable<String>(cageId.value);
    }
    if (eggWeightGrams.present) {
      map['egg_weight_grams'] = Variable<String>(eggWeightGrams.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (collectedAt.present) {
      map['collected_at'] = Variable<DateTime>(collectedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EggCollectionsCompanion(')
          ..write('id: $id, ')
          ..write('cageId: $cageId, ')
          ..write('eggWeightGrams: $eggWeightGrams, ')
          ..write('quality: $quality, ')
          ..write('collectedAt: $collectedAt, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CageMaintenancesTable extends CageMaintenances
    with TableInfo<$CageMaintenancesTable, CageMaintenance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CageMaintenancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cageIdMeta = const VerificationMeta('cageId');
  @override
  late final GeneratedColumn<String> cageId = GeneratedColumn<String>(
    'cage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maintenanceDateMeta = const VerificationMeta(
    'maintenanceDate',
  );
  @override
  late final GeneratedColumn<DateTime> maintenanceDate =
      GeneratedColumn<DateTime>(
        'maintenance_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _waterChangedMeta = const VerificationMeta(
    'waterChanged',
  );
  @override
  late final GeneratedColumn<bool> waterChanged = GeneratedColumn<bool>(
    'water_changed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("water_changed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _attractantReplacedMeta =
      const VerificationMeta('attractantReplaced');
  @override
  late final GeneratedColumn<bool> attractantReplaced = GeneratedColumn<bool>(
    'attractant_replaced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("attractant_replaced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cleaningDoneMeta = const VerificationMeta(
    'cleaningDone',
  );
  @override
  late final GeneratedColumn<bool> cleaningDone = GeneratedColumn<bool>(
    'cleaning_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cleaning_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cageId,
    maintenanceDate,
    waterChanged,
    attractantReplaced,
    cleaningDone,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cage_maintenances';
  @override
  VerificationContext validateIntegrity(
    Insertable<CageMaintenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cage_id')) {
      context.handle(
        _cageIdMeta,
        cageId.isAcceptableOrUnknown(data['cage_id']!, _cageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cageIdMeta);
    }
    if (data.containsKey('maintenance_date')) {
      context.handle(
        _maintenanceDateMeta,
        maintenanceDate.isAcceptableOrUnknown(
          data['maintenance_date']!,
          _maintenanceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maintenanceDateMeta);
    }
    if (data.containsKey('water_changed')) {
      context.handle(
        _waterChangedMeta,
        waterChanged.isAcceptableOrUnknown(
          data['water_changed']!,
          _waterChangedMeta,
        ),
      );
    }
    if (data.containsKey('attractant_replaced')) {
      context.handle(
        _attractantReplacedMeta,
        attractantReplaced.isAcceptableOrUnknown(
          data['attractant_replaced']!,
          _attractantReplacedMeta,
        ),
      );
    }
    if (data.containsKey('cleaning_done')) {
      context.handle(
        _cleaningDoneMeta,
        cleaningDone.isAcceptableOrUnknown(
          data['cleaning_done']!,
          _cleaningDoneMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CageMaintenance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CageMaintenance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cage_id'],
      )!,
      maintenanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}maintenance_date'],
      )!,
      waterChanged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}water_changed'],
      )!,
      attractantReplaced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}attractant_replaced'],
      )!,
      cleaningDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cleaning_done'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CageMaintenancesTable createAlias(String alias) {
    return $CageMaintenancesTable(attachedDatabase, alias);
  }
}

class CageMaintenance extends DataClass implements Insertable<CageMaintenance> {
  final int id;
  final String cageId;
  final DateTime maintenanceDate;
  final bool waterChanged;
  final bool attractantReplaced;
  final bool cleaningDone;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CageMaintenance({
    required this.id,
    required this.cageId,
    required this.maintenanceDate,
    required this.waterChanged,
    required this.attractantReplaced,
    required this.cleaningDone,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cage_id'] = Variable<String>(cageId);
    map['maintenance_date'] = Variable<DateTime>(maintenanceDate);
    map['water_changed'] = Variable<bool>(waterChanged);
    map['attractant_replaced'] = Variable<bool>(attractantReplaced);
    map['cleaning_done'] = Variable<bool>(cleaningDone);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CageMaintenancesCompanion toCompanion(bool nullToAbsent) {
    return CageMaintenancesCompanion(
      id: Value(id),
      cageId: Value(cageId),
      maintenanceDate: Value(maintenanceDate),
      waterChanged: Value(waterChanged),
      attractantReplaced: Value(attractantReplaced),
      cleaningDone: Value(cleaningDone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CageMaintenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CageMaintenance(
      id: serializer.fromJson<int>(json['id']),
      cageId: serializer.fromJson<String>(json['cageId']),
      maintenanceDate: serializer.fromJson<DateTime>(json['maintenanceDate']),
      waterChanged: serializer.fromJson<bool>(json['waterChanged']),
      attractantReplaced: serializer.fromJson<bool>(json['attractantReplaced']),
      cleaningDone: serializer.fromJson<bool>(json['cleaningDone']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cageId': serializer.toJson<String>(cageId),
      'maintenanceDate': serializer.toJson<DateTime>(maintenanceDate),
      'waterChanged': serializer.toJson<bool>(waterChanged),
      'attractantReplaced': serializer.toJson<bool>(attractantReplaced),
      'cleaningDone': serializer.toJson<bool>(cleaningDone),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CageMaintenance copyWith({
    int? id,
    String? cageId,
    DateTime? maintenanceDate,
    bool? waterChanged,
    bool? attractantReplaced,
    bool? cleaningDone,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CageMaintenance(
    id: id ?? this.id,
    cageId: cageId ?? this.cageId,
    maintenanceDate: maintenanceDate ?? this.maintenanceDate,
    waterChanged: waterChanged ?? this.waterChanged,
    attractantReplaced: attractantReplaced ?? this.attractantReplaced,
    cleaningDone: cleaningDone ?? this.cleaningDone,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CageMaintenance copyWithCompanion(CageMaintenancesCompanion data) {
    return CageMaintenance(
      id: data.id.present ? data.id.value : this.id,
      cageId: data.cageId.present ? data.cageId.value : this.cageId,
      maintenanceDate: data.maintenanceDate.present
          ? data.maintenanceDate.value
          : this.maintenanceDate,
      waterChanged: data.waterChanged.present
          ? data.waterChanged.value
          : this.waterChanged,
      attractantReplaced: data.attractantReplaced.present
          ? data.attractantReplaced.value
          : this.attractantReplaced,
      cleaningDone: data.cleaningDone.present
          ? data.cleaningDone.value
          : this.cleaningDone,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CageMaintenance(')
          ..write('id: $id, ')
          ..write('cageId: $cageId, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('waterChanged: $waterChanged, ')
          ..write('attractantReplaced: $attractantReplaced, ')
          ..write('cleaningDone: $cleaningDone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cageId,
    maintenanceDate,
    waterChanged,
    attractantReplaced,
    cleaningDone,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CageMaintenance &&
          other.id == this.id &&
          other.cageId == this.cageId &&
          other.maintenanceDate == this.maintenanceDate &&
          other.waterChanged == this.waterChanged &&
          other.attractantReplaced == this.attractantReplaced &&
          other.cleaningDone == this.cleaningDone &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CageMaintenancesCompanion extends UpdateCompanion<CageMaintenance> {
  final Value<int> id;
  final Value<String> cageId;
  final Value<DateTime> maintenanceDate;
  final Value<bool> waterChanged;
  final Value<bool> attractantReplaced;
  final Value<bool> cleaningDone;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CageMaintenancesCompanion({
    this.id = const Value.absent(),
    this.cageId = const Value.absent(),
    this.maintenanceDate = const Value.absent(),
    this.waterChanged = const Value.absent(),
    this.attractantReplaced = const Value.absent(),
    this.cleaningDone = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CageMaintenancesCompanion.insert({
    this.id = const Value.absent(),
    required String cageId,
    required DateTime maintenanceDate,
    this.waterChanged = const Value.absent(),
    this.attractantReplaced = const Value.absent(),
    this.cleaningDone = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : cageId = Value(cageId),
       maintenanceDate = Value(maintenanceDate);
  static Insertable<CageMaintenance> custom({
    Expression<int>? id,
    Expression<String>? cageId,
    Expression<DateTime>? maintenanceDate,
    Expression<bool>? waterChanged,
    Expression<bool>? attractantReplaced,
    Expression<bool>? cleaningDone,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cageId != null) 'cage_id': cageId,
      if (maintenanceDate != null) 'maintenance_date': maintenanceDate,
      if (waterChanged != null) 'water_changed': waterChanged,
      if (attractantReplaced != null) 'attractant_replaced': attractantReplaced,
      if (cleaningDone != null) 'cleaning_done': cleaningDone,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CageMaintenancesCompanion copyWith({
    Value<int>? id,
    Value<String>? cageId,
    Value<DateTime>? maintenanceDate,
    Value<bool>? waterChanged,
    Value<bool>? attractantReplaced,
    Value<bool>? cleaningDone,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CageMaintenancesCompanion(
      id: id ?? this.id,
      cageId: cageId ?? this.cageId,
      maintenanceDate: maintenanceDate ?? this.maintenanceDate,
      waterChanged: waterChanged ?? this.waterChanged,
      attractantReplaced: attractantReplaced ?? this.attractantReplaced,
      cleaningDone: cleaningDone ?? this.cleaningDone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cageId.present) {
      map['cage_id'] = Variable<String>(cageId.value);
    }
    if (maintenanceDate.present) {
      map['maintenance_date'] = Variable<DateTime>(maintenanceDate.value);
    }
    if (waterChanged.present) {
      map['water_changed'] = Variable<bool>(waterChanged.value);
    }
    if (attractantReplaced.present) {
      map['attractant_replaced'] = Variable<bool>(attractantReplaced.value);
    }
    if (cleaningDone.present) {
      map['cleaning_done'] = Variable<bool>(cleaningDone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CageMaintenancesCompanion(')
          ..write('id: $id, ')
          ..write('cageId: $cageId, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('waterChanged: $waterChanged, ')
          ..write('attractantReplaced: $attractantReplaced, ')
          ..write('cleaningDone: $cleaningDone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxesTable extends SyncOutboxes
    with TableInfo<$SyncOutboxesTable, SyncOutboxe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    status,
    operation,
    payload,
    retryCount,
    errorMessage,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outboxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncOutboxesTable createAlias(String alias) {
    return $SyncOutboxesTable(attachedDatabase, alias);
  }
}

class SyncOutboxe extends DataClass implements Insertable<SyncOutboxe> {
  final int id;
  final String entityType;
  final String? entityId;
  final String status;
  final String operation;
  final String payload;
  final int retryCount;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncOutboxe({
    required this.id,
    required this.entityType,
    this.entityId,
    required this.status,
    required this.operation,
    required this.payload,
    required this.retryCount,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    map['status'] = Variable<String>(status);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncOutboxesCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxesCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      status: Value(status),
      operation: Value(operation),
      payload: Value(payload),
      retryCount: Value(retryCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncOutboxe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxe(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      status: serializer.fromJson<String>(json['status']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'status': serializer.toJson<String>(status),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncOutboxe copyWith({
    int? id,
    String? entityType,
    Value<String?> entityId = const Value.absent(),
    String? status,
    String? operation,
    String? payload,
    int? retryCount,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyncOutboxe(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    status: status ?? this.status,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    retryCount: retryCount ?? this.retryCount,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncOutboxe copyWithCompanion(SyncOutboxesCompanion data) {
    return SyncOutboxe(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      status: data.status.present ? data.status.value : this.status,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxe(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('status: $status, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    status,
    operation,
    payload,
    retryCount,
    errorMessage,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxe &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.status == this.status &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncOutboxesCompanion extends UpdateCompanion<SyncOutboxe> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String?> entityId;
  final Value<String> status;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncOutboxesCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.status = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncOutboxesCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    this.entityId = const Value.absent(),
    this.status = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : entityType = Value(entityType);
  static Insertable<SyncOutboxe> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? status,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (status != null) 'status': status,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncOutboxesCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String?>? entityId,
    Value<String>? status,
    Value<String>? operation,
    Value<String>? payload,
    Value<int>? retryCount,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SyncOutboxesCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      status: status ?? this.status,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxesCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('status: $status, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $BreedingCagesTable breedingCages = $BreedingCagesTable(this);
  late final $FeedingsTable feedings = $FeedingsTable(this);
  late final $HarvestsTable harvests = $HarvestsTable(this);
  late final $EggCollectionsTable eggCollections = $EggCollectionsTable(this);
  late final $CageMaintenancesTable cageMaintenances = $CageMaintenancesTable(
    this,
  );
  late final $SyncOutboxesTable syncOutboxes = $SyncOutboxesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    batches,
    breedingCages,
    feedings,
    harvests,
    eggCollections,
    cageMaintenances,
    syncOutboxes,
  ];
}

typedef $$BatchesTableCreateCompanionBuilder =
    BatchesCompanion Function({
      Value<int> id,
      Value<String> batchNumber,
      Value<String> farmerId,
      Value<String> farmerName,
      Value<String> wasteType,
      Value<double> wasteQuantityKg,
      Value<int> neonatesAdded,
      Value<String> status,
      Value<int> dayNumber,
      required String startDate,
      required String expectedHarvestDate,
      Value<String?> actualHarvestDate,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BatchesTableUpdateCompanionBuilder =
    BatchesCompanion Function({
      Value<int> id,
      Value<String> batchNumber,
      Value<String> farmerId,
      Value<String> farmerName,
      Value<String> wasteType,
      Value<double> wasteQuantityKg,
      Value<int> neonatesAdded,
      Value<String> status,
      Value<int> dayNumber,
      Value<String> startDate,
      Value<String> expectedHarvestDate,
      Value<String?> actualHarvestDate,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BatchesTableFilterComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerName => $composableBuilder(
    column: $table.farmerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wasteType => $composableBuilder(
    column: $table.wasteType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get neonatesAdded => $composableBuilder(
    column: $table.neonatesAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedHarvestDate => $composableBuilder(
    column: $table.expectedHarvestDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualHarvestDate => $composableBuilder(
    column: $table.actualHarvestDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerName => $composableBuilder(
    column: $table.farmerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wasteType => $composableBuilder(
    column: $table.wasteType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get neonatesAdded => $composableBuilder(
    column: $table.neonatesAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedHarvestDate => $composableBuilder(
    column: $table.expectedHarvestDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualHarvestDate => $composableBuilder(
    column: $table.actualHarvestDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<String> get farmerName => $composableBuilder(
    column: $table.farmerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wasteType =>
      $composableBuilder(column: $table.wasteType, builder: (column) => column);

  GeneratedColumn<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get neonatesAdded => $composableBuilder(
    column: $table.neonatesAdded,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get expectedHarvestDate => $composableBuilder(
    column: $table.expectedHarvestDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualHarvestDate => $composableBuilder(
    column: $table.actualHarvestDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchesTable,
          Batche,
          $$BatchesTableFilterComposer,
          $$BatchesTableOrderingComposer,
          $$BatchesTableAnnotationComposer,
          $$BatchesTableCreateCompanionBuilder,
          $$BatchesTableUpdateCompanionBuilder,
          (Batche, BaseReferences<_$AppDatabase, $BatchesTable, Batche>),
          Batche,
          PrefetchHooks Function()
        > {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> farmerName = const Value.absent(),
                Value<String> wasteType = const Value.absent(),
                Value<double> wasteQuantityKg = const Value.absent(),
                Value<int> neonatesAdded = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> expectedHarvestDate = const Value.absent(),
                Value<String?> actualHarvestDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BatchesCompanion(
                id: id,
                batchNumber: batchNumber,
                farmerId: farmerId,
                farmerName: farmerName,
                wasteType: wasteType,
                wasteQuantityKg: wasteQuantityKg,
                neonatesAdded: neonatesAdded,
                status: status,
                dayNumber: dayNumber,
                startDate: startDate,
                expectedHarvestDate: expectedHarvestDate,
                actualHarvestDate: actualHarvestDate,
                notes: notes,
                photoUrl: photoUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> farmerName = const Value.absent(),
                Value<String> wasteType = const Value.absent(),
                Value<double> wasteQuantityKg = const Value.absent(),
                Value<int> neonatesAdded = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                required String startDate,
                required String expectedHarvestDate,
                Value<String?> actualHarvestDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BatchesCompanion.insert(
                id: id,
                batchNumber: batchNumber,
                farmerId: farmerId,
                farmerName: farmerName,
                wasteType: wasteType,
                wasteQuantityKg: wasteQuantityKg,
                neonatesAdded: neonatesAdded,
                status: status,
                dayNumber: dayNumber,
                startDate: startDate,
                expectedHarvestDate: expectedHarvestDate,
                actualHarvestDate: actualHarvestDate,
                notes: notes,
                photoUrl: photoUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchesTable,
      Batche,
      $$BatchesTableFilterComposer,
      $$BatchesTableOrderingComposer,
      $$BatchesTableAnnotationComposer,
      $$BatchesTableCreateCompanionBuilder,
      $$BatchesTableUpdateCompanionBuilder,
      (Batche, BaseReferences<_$AppDatabase, $BatchesTable, Batche>),
      Batche,
      PrefetchHooks Function()
    >;
typedef $$BreedingCagesTableCreateCompanionBuilder =
    BreedingCagesCompanion Function({
      Value<int> id,
      Value<String> cageNumber,
      Value<String> farmerId,
      Value<String> status,
      Value<int> ageDays,
      Value<double> pupaLoadedKg,
      Value<String?> pupaSource,
      Value<DateTime?> breedingDate,
      Value<DateTime?> lastMaintenanceDate,
      Value<bool> attractantInstalled,
      Value<bool> waterAdded,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BreedingCagesTableUpdateCompanionBuilder =
    BreedingCagesCompanion Function({
      Value<int> id,
      Value<String> cageNumber,
      Value<String> farmerId,
      Value<String> status,
      Value<int> ageDays,
      Value<double> pupaLoadedKg,
      Value<String?> pupaSource,
      Value<DateTime?> breedingDate,
      Value<DateTime?> lastMaintenanceDate,
      Value<bool> attractantInstalled,
      Value<bool> waterAdded,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BreedingCagesTableFilterComposer
    extends Composer<_$AppDatabase, $BreedingCagesTable> {
  $$BreedingCagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cageNumber => $composableBuilder(
    column: $table.cageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ageDays => $composableBuilder(
    column: $table.ageDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pupaLoadedKg => $composableBuilder(
    column: $table.pupaLoadedKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pupaSource => $composableBuilder(
    column: $table.pupaSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get breedingDate => $composableBuilder(
    column: $table.breedingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMaintenanceDate => $composableBuilder(
    column: $table.lastMaintenanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get attractantInstalled => $composableBuilder(
    column: $table.attractantInstalled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get waterAdded => $composableBuilder(
    column: $table.waterAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BreedingCagesTableOrderingComposer
    extends Composer<_$AppDatabase, $BreedingCagesTable> {
  $$BreedingCagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cageNumber => $composableBuilder(
    column: $table.cageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ageDays => $composableBuilder(
    column: $table.ageDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pupaLoadedKg => $composableBuilder(
    column: $table.pupaLoadedKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pupaSource => $composableBuilder(
    column: $table.pupaSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get breedingDate => $composableBuilder(
    column: $table.breedingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMaintenanceDate => $composableBuilder(
    column: $table.lastMaintenanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get attractantInstalled => $composableBuilder(
    column: $table.attractantInstalled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get waterAdded => $composableBuilder(
    column: $table.waterAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BreedingCagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BreedingCagesTable> {
  $$BreedingCagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cageNumber => $composableBuilder(
    column: $table.cageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get ageDays =>
      $composableBuilder(column: $table.ageDays, builder: (column) => column);

  GeneratedColumn<double> get pupaLoadedKg => $composableBuilder(
    column: $table.pupaLoadedKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pupaSource => $composableBuilder(
    column: $table.pupaSource,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get breedingDate => $composableBuilder(
    column: $table.breedingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMaintenanceDate => $composableBuilder(
    column: $table.lastMaintenanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get attractantInstalled => $composableBuilder(
    column: $table.attractantInstalled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get waterAdded => $composableBuilder(
    column: $table.waterAdded,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BreedingCagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BreedingCagesTable,
          BreedingCage,
          $$BreedingCagesTableFilterComposer,
          $$BreedingCagesTableOrderingComposer,
          $$BreedingCagesTableAnnotationComposer,
          $$BreedingCagesTableCreateCompanionBuilder,
          $$BreedingCagesTableUpdateCompanionBuilder,
          (
            BreedingCage,
            BaseReferences<_$AppDatabase, $BreedingCagesTable, BreedingCage>,
          ),
          BreedingCage,
          PrefetchHooks Function()
        > {
  $$BreedingCagesTableTableManager(_$AppDatabase db, $BreedingCagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BreedingCagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BreedingCagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BreedingCagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cageNumber = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> ageDays = const Value.absent(),
                Value<double> pupaLoadedKg = const Value.absent(),
                Value<String?> pupaSource = const Value.absent(),
                Value<DateTime?> breedingDate = const Value.absent(),
                Value<DateTime?> lastMaintenanceDate = const Value.absent(),
                Value<bool> attractantInstalled = const Value.absent(),
                Value<bool> waterAdded = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BreedingCagesCompanion(
                id: id,
                cageNumber: cageNumber,
                farmerId: farmerId,
                status: status,
                ageDays: ageDays,
                pupaLoadedKg: pupaLoadedKg,
                pupaSource: pupaSource,
                breedingDate: breedingDate,
                lastMaintenanceDate: lastMaintenanceDate,
                attractantInstalled: attractantInstalled,
                waterAdded: waterAdded,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cageNumber = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> ageDays = const Value.absent(),
                Value<double> pupaLoadedKg = const Value.absent(),
                Value<String?> pupaSource = const Value.absent(),
                Value<DateTime?> breedingDate = const Value.absent(),
                Value<DateTime?> lastMaintenanceDate = const Value.absent(),
                Value<bool> attractantInstalled = const Value.absent(),
                Value<bool> waterAdded = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BreedingCagesCompanion.insert(
                id: id,
                cageNumber: cageNumber,
                farmerId: farmerId,
                status: status,
                ageDays: ageDays,
                pupaLoadedKg: pupaLoadedKg,
                pupaSource: pupaSource,
                breedingDate: breedingDate,
                lastMaintenanceDate: lastMaintenanceDate,
                attractantInstalled: attractantInstalled,
                waterAdded: waterAdded,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BreedingCagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BreedingCagesTable,
      BreedingCage,
      $$BreedingCagesTableFilterComposer,
      $$BreedingCagesTableOrderingComposer,
      $$BreedingCagesTableAnnotationComposer,
      $$BreedingCagesTableCreateCompanionBuilder,
      $$BreedingCagesTableUpdateCompanionBuilder,
      (
        BreedingCage,
        BaseReferences<_$AppDatabase, $BreedingCagesTable, BreedingCage>,
      ),
      BreedingCage,
      PrefetchHooks Function()
    >;
typedef $$FeedingsTableCreateCompanionBuilder =
    FeedingsCompanion Function({
      Value<int> id,
      required String batchId,
      required double wasteQuantityKg,
      required String wasteType,
      required DateTime fedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$FeedingsTableUpdateCompanionBuilder =
    FeedingsCompanion Function({
      Value<int> id,
      Value<String> batchId,
      Value<double> wasteQuantityKg,
      Value<String> wasteType,
      Value<DateTime> fedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$FeedingsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wasteType => $composableBuilder(
    column: $table.wasteType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fedAt => $composableBuilder(
    column: $table.fedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wasteType => $composableBuilder(
    column: $table.wasteType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fedAt => $composableBuilder(
    column: $table.fedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => column);

  GeneratedColumn<double> get wasteQuantityKg => $composableBuilder(
    column: $table.wasteQuantityKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wasteType =>
      $composableBuilder(column: $table.wasteType, builder: (column) => column);

  GeneratedColumn<DateTime> get fedAt =>
      $composableBuilder(column: $table.fedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FeedingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedingsTable,
          Feeding,
          $$FeedingsTableFilterComposer,
          $$FeedingsTableOrderingComposer,
          $$FeedingsTableAnnotationComposer,
          $$FeedingsTableCreateCompanionBuilder,
          $$FeedingsTableUpdateCompanionBuilder,
          (Feeding, BaseReferences<_$AppDatabase, $FeedingsTable, Feeding>),
          Feeding,
          PrefetchHooks Function()
        > {
  $$FeedingsTableTableManager(_$AppDatabase db, $FeedingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<double> wasteQuantityKg = const Value.absent(),
                Value<String> wasteType = const Value.absent(),
                Value<DateTime> fedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FeedingsCompanion(
                id: id,
                batchId: batchId,
                wasteQuantityKg: wasteQuantityKg,
                wasteType: wasteType,
                fedAt: fedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String batchId,
                required double wasteQuantityKg,
                required String wasteType,
                required DateTime fedAt,
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FeedingsCompanion.insert(
                id: id,
                batchId: batchId,
                wasteQuantityKg: wasteQuantityKg,
                wasteType: wasteType,
                fedAt: fedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedingsTable,
      Feeding,
      $$FeedingsTableFilterComposer,
      $$FeedingsTableOrderingComposer,
      $$FeedingsTableAnnotationComposer,
      $$FeedingsTableCreateCompanionBuilder,
      $$FeedingsTableUpdateCompanionBuilder,
      (Feeding, BaseReferences<_$AppDatabase, $FeedingsTable, Feeding>),
      Feeding,
      PrefetchHooks Function()
    >;
typedef $$HarvestsTableCreateCompanionBuilder =
    HarvestsCompanion Function({
      Value<int> id,
      required String batchId,
      required double wetLarvaeKg,
      Value<double?> frassKg,
      Value<double?> pupaKg,
      required DateTime harvestedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$HarvestsTableUpdateCompanionBuilder =
    HarvestsCompanion Function({
      Value<int> id,
      Value<String> batchId,
      Value<double> wetLarvaeKg,
      Value<double?> frassKg,
      Value<double?> pupaKg,
      Value<DateTime> harvestedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$HarvestsTableFilterComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wetLarvaeKg => $composableBuilder(
    column: $table.wetLarvaeKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get frassKg => $composableBuilder(
    column: $table.frassKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pupaKg => $composableBuilder(
    column: $table.pupaKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get harvestedAt => $composableBuilder(
    column: $table.harvestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HarvestsTableOrderingComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wetLarvaeKg => $composableBuilder(
    column: $table.wetLarvaeKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get frassKg => $composableBuilder(
    column: $table.frassKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pupaKg => $composableBuilder(
    column: $table.pupaKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get harvestedAt => $composableBuilder(
    column: $table.harvestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HarvestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HarvestsTable> {
  $$HarvestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => column);

  GeneratedColumn<double> get wetLarvaeKg => $composableBuilder(
    column: $table.wetLarvaeKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get frassKg =>
      $composableBuilder(column: $table.frassKg, builder: (column) => column);

  GeneratedColumn<double> get pupaKg =>
      $composableBuilder(column: $table.pupaKg, builder: (column) => column);

  GeneratedColumn<DateTime> get harvestedAt => $composableBuilder(
    column: $table.harvestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HarvestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HarvestsTable,
          Harvest,
          $$HarvestsTableFilterComposer,
          $$HarvestsTableOrderingComposer,
          $$HarvestsTableAnnotationComposer,
          $$HarvestsTableCreateCompanionBuilder,
          $$HarvestsTableUpdateCompanionBuilder,
          (Harvest, BaseReferences<_$AppDatabase, $HarvestsTable, Harvest>),
          Harvest,
          PrefetchHooks Function()
        > {
  $$HarvestsTableTableManager(_$AppDatabase db, $HarvestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HarvestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HarvestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HarvestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<double> wetLarvaeKg = const Value.absent(),
                Value<double?> frassKg = const Value.absent(),
                Value<double?> pupaKg = const Value.absent(),
                Value<DateTime> harvestedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HarvestsCompanion(
                id: id,
                batchId: batchId,
                wetLarvaeKg: wetLarvaeKg,
                frassKg: frassKg,
                pupaKg: pupaKg,
                harvestedAt: harvestedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String batchId,
                required double wetLarvaeKg,
                Value<double?> frassKg = const Value.absent(),
                Value<double?> pupaKg = const Value.absent(),
                required DateTime harvestedAt,
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HarvestsCompanion.insert(
                id: id,
                batchId: batchId,
                wetLarvaeKg: wetLarvaeKg,
                frassKg: frassKg,
                pupaKg: pupaKg,
                harvestedAt: harvestedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HarvestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HarvestsTable,
      Harvest,
      $$HarvestsTableFilterComposer,
      $$HarvestsTableOrderingComposer,
      $$HarvestsTableAnnotationComposer,
      $$HarvestsTableCreateCompanionBuilder,
      $$HarvestsTableUpdateCompanionBuilder,
      (Harvest, BaseReferences<_$AppDatabase, $HarvestsTable, Harvest>),
      Harvest,
      PrefetchHooks Function()
    >;
typedef $$EggCollectionsTableCreateCompanionBuilder =
    EggCollectionsCompanion Function({
      Value<int> id,
      required String cageId,
      Value<String> eggWeightGrams,
      Value<String> quality,
      required DateTime collectedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$EggCollectionsTableUpdateCompanionBuilder =
    EggCollectionsCompanion Function({
      Value<int> id,
      Value<String> cageId,
      Value<String> eggWeightGrams,
      Value<String> quality,
      Value<DateTime> collectedAt,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$EggCollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $EggCollectionsTable> {
  $$EggCollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cageId => $composableBuilder(
    column: $table.cageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eggWeightGrams => $composableBuilder(
    column: $table.eggWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EggCollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EggCollectionsTable> {
  $$EggCollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cageId => $composableBuilder(
    column: $table.cageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eggWeightGrams => $composableBuilder(
    column: $table.eggWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EggCollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EggCollectionsTable> {
  $$EggCollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cageId =>
      $composableBuilder(column: $table.cageId, builder: (column) => column);

  GeneratedColumn<String> get eggWeightGrams => $composableBuilder(
    column: $table.eggWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<DateTime> get collectedAt => $composableBuilder(
    column: $table.collectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EggCollectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EggCollectionsTable,
          EggCollection,
          $$EggCollectionsTableFilterComposer,
          $$EggCollectionsTableOrderingComposer,
          $$EggCollectionsTableAnnotationComposer,
          $$EggCollectionsTableCreateCompanionBuilder,
          $$EggCollectionsTableUpdateCompanionBuilder,
          (
            EggCollection,
            BaseReferences<_$AppDatabase, $EggCollectionsTable, EggCollection>,
          ),
          EggCollection,
          PrefetchHooks Function()
        > {
  $$EggCollectionsTableTableManager(
    _$AppDatabase db,
    $EggCollectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EggCollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EggCollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EggCollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cageId = const Value.absent(),
                Value<String> eggWeightGrams = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<DateTime> collectedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EggCollectionsCompanion(
                id: id,
                cageId: cageId,
                eggWeightGrams: eggWeightGrams,
                quality: quality,
                collectedAt: collectedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cageId,
                Value<String> eggWeightGrams = const Value.absent(),
                Value<String> quality = const Value.absent(),
                required DateTime collectedAt,
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EggCollectionsCompanion.insert(
                id: id,
                cageId: cageId,
                eggWeightGrams: eggWeightGrams,
                quality: quality,
                collectedAt: collectedAt,
                notes: notes,
                photoUrl: photoUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EggCollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EggCollectionsTable,
      EggCollection,
      $$EggCollectionsTableFilterComposer,
      $$EggCollectionsTableOrderingComposer,
      $$EggCollectionsTableAnnotationComposer,
      $$EggCollectionsTableCreateCompanionBuilder,
      $$EggCollectionsTableUpdateCompanionBuilder,
      (
        EggCollection,
        BaseReferences<_$AppDatabase, $EggCollectionsTable, EggCollection>,
      ),
      EggCollection,
      PrefetchHooks Function()
    >;
typedef $$CageMaintenancesTableCreateCompanionBuilder =
    CageMaintenancesCompanion Function({
      Value<int> id,
      required String cageId,
      required DateTime maintenanceDate,
      Value<bool> waterChanged,
      Value<bool> attractantReplaced,
      Value<bool> cleaningDone,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CageMaintenancesTableUpdateCompanionBuilder =
    CageMaintenancesCompanion Function({
      Value<int> id,
      Value<String> cageId,
      Value<DateTime> maintenanceDate,
      Value<bool> waterChanged,
      Value<bool> attractantReplaced,
      Value<bool> cleaningDone,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CageMaintenancesTableFilterComposer
    extends Composer<_$AppDatabase, $CageMaintenancesTable> {
  $$CageMaintenancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cageId => $composableBuilder(
    column: $table.cageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get waterChanged => $composableBuilder(
    column: $table.waterChanged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get attractantReplaced => $composableBuilder(
    column: $table.attractantReplaced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cleaningDone => $composableBuilder(
    column: $table.cleaningDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CageMaintenancesTableOrderingComposer
    extends Composer<_$AppDatabase, $CageMaintenancesTable> {
  $$CageMaintenancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cageId => $composableBuilder(
    column: $table.cageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get waterChanged => $composableBuilder(
    column: $table.waterChanged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get attractantReplaced => $composableBuilder(
    column: $table.attractantReplaced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cleaningDone => $composableBuilder(
    column: $table.cleaningDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CageMaintenancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CageMaintenancesTable> {
  $$CageMaintenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cageId =>
      $composableBuilder(column: $table.cageId, builder: (column) => column);

  GeneratedColumn<DateTime> get maintenanceDate => $composableBuilder(
    column: $table.maintenanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get waterChanged => $composableBuilder(
    column: $table.waterChanged,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get attractantReplaced => $composableBuilder(
    column: $table.attractantReplaced,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cleaningDone => $composableBuilder(
    column: $table.cleaningDone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CageMaintenancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CageMaintenancesTable,
          CageMaintenance,
          $$CageMaintenancesTableFilterComposer,
          $$CageMaintenancesTableOrderingComposer,
          $$CageMaintenancesTableAnnotationComposer,
          $$CageMaintenancesTableCreateCompanionBuilder,
          $$CageMaintenancesTableUpdateCompanionBuilder,
          (
            CageMaintenance,
            BaseReferences<
              _$AppDatabase,
              $CageMaintenancesTable,
              CageMaintenance
            >,
          ),
          CageMaintenance,
          PrefetchHooks Function()
        > {
  $$CageMaintenancesTableTableManager(
    _$AppDatabase db,
    $CageMaintenancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CageMaintenancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CageMaintenancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CageMaintenancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cageId = const Value.absent(),
                Value<DateTime> maintenanceDate = const Value.absent(),
                Value<bool> waterChanged = const Value.absent(),
                Value<bool> attractantReplaced = const Value.absent(),
                Value<bool> cleaningDone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CageMaintenancesCompanion(
                id: id,
                cageId: cageId,
                maintenanceDate: maintenanceDate,
                waterChanged: waterChanged,
                attractantReplaced: attractantReplaced,
                cleaningDone: cleaningDone,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cageId,
                required DateTime maintenanceDate,
                Value<bool> waterChanged = const Value.absent(),
                Value<bool> attractantReplaced = const Value.absent(),
                Value<bool> cleaningDone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CageMaintenancesCompanion.insert(
                id: id,
                cageId: cageId,
                maintenanceDate: maintenanceDate,
                waterChanged: waterChanged,
                attractantReplaced: attractantReplaced,
                cleaningDone: cleaningDone,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CageMaintenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CageMaintenancesTable,
      CageMaintenance,
      $$CageMaintenancesTableFilterComposer,
      $$CageMaintenancesTableOrderingComposer,
      $$CageMaintenancesTableAnnotationComposer,
      $$CageMaintenancesTableCreateCompanionBuilder,
      $$CageMaintenancesTableUpdateCompanionBuilder,
      (
        CageMaintenance,
        BaseReferences<_$AppDatabase, $CageMaintenancesTable, CageMaintenance>,
      ),
      CageMaintenance,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxesTableCreateCompanionBuilder =
    SyncOutboxesCompanion Function({
      Value<int> id,
      required String entityType,
      Value<String?> entityId,
      Value<String> status,
      Value<String> operation,
      Value<String> payload,
      Value<int> retryCount,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SyncOutboxesTableUpdateCompanionBuilder =
    SyncOutboxesCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String?> entityId,
      Value<String> status,
      Value<String> operation,
      Value<String> payload,
      Value<int> retryCount,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SyncOutboxesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxesTable> {
  $$SyncOutboxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxesTable> {
  $$SyncOutboxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxesTable> {
  $$SyncOutboxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncOutboxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxesTable,
          SyncOutboxe,
          $$SyncOutboxesTableFilterComposer,
          $$SyncOutboxesTableOrderingComposer,
          $$SyncOutboxesTableAnnotationComposer,
          $$SyncOutboxesTableCreateCompanionBuilder,
          $$SyncOutboxesTableUpdateCompanionBuilder,
          (
            SyncOutboxe,
            BaseReferences<_$AppDatabase, $SyncOutboxesTable, SyncOutboxe>,
          ),
          SyncOutboxe,
          PrefetchHooks Function()
        > {
  $$SyncOutboxesTableTableManager(_$AppDatabase db, $SyncOutboxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncOutboxesCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                status: status,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                Value<String?> entityId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncOutboxesCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                status: status,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxesTable,
      SyncOutboxe,
      $$SyncOutboxesTableFilterComposer,
      $$SyncOutboxesTableOrderingComposer,
      $$SyncOutboxesTableAnnotationComposer,
      $$SyncOutboxesTableCreateCompanionBuilder,
      $$SyncOutboxesTableUpdateCompanionBuilder,
      (
        SyncOutboxe,
        BaseReferences<_$AppDatabase, $SyncOutboxesTable, SyncOutboxe>,
      ),
      SyncOutboxe,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db, _db.batches);
  $$BreedingCagesTableTableManager get breedingCages =>
      $$BreedingCagesTableTableManager(_db, _db.breedingCages);
  $$FeedingsTableTableManager get feedings =>
      $$FeedingsTableTableManager(_db, _db.feedings);
  $$HarvestsTableTableManager get harvests =>
      $$HarvestsTableTableManager(_db, _db.harvests);
  $$EggCollectionsTableTableManager get eggCollections =>
      $$EggCollectionsTableTableManager(_db, _db.eggCollections);
  $$CageMaintenancesTableTableManager get cageMaintenances =>
      $$CageMaintenancesTableTableManager(_db, _db.cageMaintenances);
  $$SyncOutboxesTableTableManager get syncOutboxes =>
      $$SyncOutboxesTableTableManager(_db, _db.syncOutboxes);
}
