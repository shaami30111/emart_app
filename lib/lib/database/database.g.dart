// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'Id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath =
      GeneratedColumn<String>('Path', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'Prompt', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'Type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'Favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("Favorite" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, imagePath, description, type, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('Id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['Id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('Path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['Path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('Prompt')) {
      context.handle(_descriptionMeta,
          description.isAcceptableOrUnknown(data['Prompt']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('Type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['Type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('Favorite')) {
      context.handle(_isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(data['Favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imagePath};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Path'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Prompt'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Type'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}Favorite'])!,
    );
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final String imagePath;
  final String description;
  final String type;
  final bool isFavorite;
  const FavoriteData(
      {required this.id,
      required this.imagePath,
      required this.description,
      required this.type,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['Id'] = Variable<int>(id);
    map['Path'] = Variable<String>(imagePath);
    map['Prompt'] = Variable<String>(description);
    map['Type'] = Variable<String>(type);
    map['Favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      description: Value(description),
      type: Value(type),
      isFavorite: Value(isFavorite),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  FavoriteData copyWith(
          {int? id,
          String? imagePath,
          String? description,
          String? type,
          bool? isFavorite}) =>
      FavoriteData(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        description: description ?? this.description,
        type: type ?? this.type,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, description, type, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.description == this.description &&
          other.type == this.type &&
          other.isFavorite == this.isFavorite);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<String> description;
  final Value<String> type;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteCompanion.insert({
    required int id,
    required String imagePath,
    required String description,
    required String type,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        imagePath = Value(imagePath),
        description = Value(description),
        type = Value(type),
        isFavorite = Value(isFavorite);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<String>? description,
    Expression<String>? type,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'Id': id,
      if (imagePath != null) 'Path': imagePath,
      if (description != null) 'Prompt': description,
      if (type != null) 'Type': type,
      if (isFavorite != null) 'Favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? imagePath,
      Value<String>? description,
      Value<String>? type,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['Id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['Path'] = Variable<String>(imagePath.value);
    }
    if (description.present) {
      map['Prompt'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['Type'] = Variable<String>(type.value);
    }
    if (isFavorite.present) {
      map['Favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MyCreationTable extends MyCreation
    with TableInfo<$MyCreationTable, MyCreationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyCreationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'Id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'imagePath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'isFavorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("isFavorite" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, imagePath, description, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_creation';
  @override
  VerificationContext validateIntegrity(Insertable<MyCreationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('Id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['Id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imagePath')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['imagePath']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('isFavorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['isFavorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MyCreationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyCreationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagePath'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}isFavorite'])!,
    );
  }

  @override
  $MyCreationTable createAlias(String alias) {
    return $MyCreationTable(attachedDatabase, alias);
  }
}

class MyCreationData extends DataClass implements Insertable<MyCreationData> {
  final int id;
  final String imagePath;
  final String description;
  final bool isFavorite;
  const MyCreationData(
      {required this.id,
      required this.imagePath,
      required this.description,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['Id'] = Variable<int>(id);
    map['imagePath'] = Variable<String>(imagePath);
    map['description'] = Variable<String>(description);
    map['isFavorite'] = Variable<bool>(isFavorite);
    return map;
  }

  MyCreationCompanion toCompanion(bool nullToAbsent) {
    return MyCreationCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      description: Value(description),
      isFavorite: Value(isFavorite),
    );
  }

  factory MyCreationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyCreationData(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      description: serializer.fromJson<String>(json['description']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'description': serializer.toJson<String>(description),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  MyCreationData copyWith(
          {int? id,
          String? imagePath,
          String? description,
          bool? isFavorite}) =>
      MyCreationData(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('MyCreationData(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, description, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyCreationData &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.description == this.description &&
          other.isFavorite == this.isFavorite);
}

class MyCreationCompanion extends UpdateCompanion<MyCreationData> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<String> description;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const MyCreationCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MyCreationCompanion.insert({
    required int id,
    required String imagePath,
    required String description,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        imagePath = Value(imagePath),
        description = Value(description),
        isFavorite = Value(isFavorite);
  static Insertable<MyCreationData> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<String>? description,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'Id': id,
      if (imagePath != null) 'imagePath': imagePath,
      if (description != null) 'description': description,
      if (isFavorite != null) 'isFavorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MyCreationCompanion copyWith(
      {Value<int>? id,
      Value<String>? imagePath,
      Value<String>? description,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return MyCreationCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['Id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['imagePath'] = Variable<String>(imagePath.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isFavorite.present) {
      map['isFavorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyCreationCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspirationFavoriteTable extends InspirationFavorite
    with TableInfo<$InspirationFavoriteTable, InspirationFavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspirationFavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'Id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path =
      GeneratedColumn<String>('Path', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _commandMeta =
      const VerificationMeta('command');
  @override
  late final GeneratedColumn<String> command = GeneratedColumn<String>(
      'command', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _proUserAccessMeta =
      const VerificationMeta('proUserAccess');
  @override
  late final GeneratedColumn<bool> proUserAccess = GeneratedColumn<bool>(
      'proUserAccess', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("proUserAccess" IN (0, 1))'));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'Favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("Favorite" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, command, proUserAccess, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspiration_favorite';
  @override
  VerificationContext validateIntegrity(
      Insertable<InspirationFavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('Id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['Id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('Path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['Path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('command')) {
      context.handle(_commandMeta,
          command.isAcceptableOrUnknown(data['command']!, _commandMeta));
    } else if (isInserting) {
      context.missing(_commandMeta);
    }
    if (data.containsKey('proUserAccess')) {
      context.handle(
          _proUserAccessMeta,
          proUserAccess.isAcceptableOrUnknown(
              data['proUserAccess']!, _proUserAccessMeta));
    } else if (isInserting) {
      context.missing(_proUserAccessMeta);
    }
    if (data.containsKey('Favorite')) {
      context.handle(_isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(data['Favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  InspirationFavoriteData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspirationFavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Path'])!,
      command: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}command'])!,
      proUserAccess: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}proUserAccess'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}Favorite'])!,
    );
  }

  @override
  $InspirationFavoriteTable createAlias(String alias) {
    return $InspirationFavoriteTable(attachedDatabase, alias);
  }
}

class InspirationFavoriteData extends DataClass
    implements Insertable<InspirationFavoriteData> {
  final int id;
  final String path;
  final String command;
  final bool proUserAccess;
  final bool isFavorite;
  const InspirationFavoriteData(
      {required this.id,
      required this.path,
      required this.command,
      required this.proUserAccess,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['Id'] = Variable<int>(id);
    map['Path'] = Variable<String>(path);
    map['command'] = Variable<String>(command);
    map['proUserAccess'] = Variable<bool>(proUserAccess);
    map['Favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  InspirationFavoriteCompanion toCompanion(bool nullToAbsent) {
    return InspirationFavoriteCompanion(
      id: Value(id),
      path: Value(path),
      command: Value(command),
      proUserAccess: Value(proUserAccess),
      isFavorite: Value(isFavorite),
    );
  }

  factory InspirationFavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspirationFavoriteData(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      command: serializer.fromJson<String>(json['command']),
      proUserAccess: serializer.fromJson<bool>(json['proUserAccess']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'command': serializer.toJson<String>(command),
      'proUserAccess': serializer.toJson<bool>(proUserAccess),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  InspirationFavoriteData copyWith(
          {int? id,
          String? path,
          String? command,
          bool? proUserAccess,
          bool? isFavorite}) =>
      InspirationFavoriteData(
        id: id ?? this.id,
        path: path ?? this.path,
        command: command ?? this.command,
        proUserAccess: proUserAccess ?? this.proUserAccess,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('InspirationFavoriteData(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('command: $command, ')
          ..write('proUserAccess: $proUserAccess, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, command, proUserAccess, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspirationFavoriteData &&
          other.id == this.id &&
          other.path == this.path &&
          other.command == this.command &&
          other.proUserAccess == this.proUserAccess &&
          other.isFavorite == this.isFavorite);
}

class InspirationFavoriteCompanion
    extends UpdateCompanion<InspirationFavoriteData> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> command;
  final Value<bool> proUserAccess;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const InspirationFavoriteCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.command = const Value.absent(),
    this.proUserAccess = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspirationFavoriteCompanion.insert({
    required int id,
    required String path,
    required String command,
    required bool proUserAccess,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        path = Value(path),
        command = Value(command),
        proUserAccess = Value(proUserAccess),
        isFavorite = Value(isFavorite);
  static Insertable<InspirationFavoriteData> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? command,
    Expression<bool>? proUserAccess,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'Id': id,
      if (path != null) 'Path': path,
      if (command != null) 'command': command,
      if (proUserAccess != null) 'proUserAccess': proUserAccess,
      if (isFavorite != null) 'Favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspirationFavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? command,
      Value<bool>? proUserAccess,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return InspirationFavoriteCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      command: command ?? this.command,
      proUserAccess: proUserAccess ?? this.proUserAccess,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['Id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['Path'] = Variable<String>(path.value);
    }
    if (command.present) {
      map['command'] = Variable<String>(command.value);
    }
    if (proUserAccess.present) {
      map['proUserAccess'] = Variable<bool>(proUserAccess.value);
    }
    if (isFavorite.present) {
      map['Favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspirationFavoriteCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('command: $command, ')
          ..write('proUserAccess: $proUserAccess, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModelFavoriteTable extends ModelFavorite
    with TableInfo<$ModelFavoriteTable, ModelFavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelFavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'Id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path =
      GeneratedColumn<String>('ImagePath', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _modelNameMeta =
      const VerificationMeta('modelName');
  @override
  late final GeneratedColumn<String> modelName = GeneratedColumn<String>(
      'ModelName', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _proUserAccessMeta =
      const VerificationMeta('proUserAccess');
  @override
  late final GeneratedColumn<bool> proUserAccess = GeneratedColumn<bool>(
      'proUserAccess', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("proUserAccess" IN (0, 1))'));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'Favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("Favorite" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, modelName, proUserAccess, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'model_favorite';
  @override
  VerificationContext validateIntegrity(Insertable<ModelFavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('Id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['Id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ImagePath')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['ImagePath']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('ModelName')) {
      context.handle(_modelNameMeta,
          modelName.isAcceptableOrUnknown(data['ModelName']!, _modelNameMeta));
    } else if (isInserting) {
      context.missing(_modelNameMeta);
    }
    if (data.containsKey('proUserAccess')) {
      context.handle(
          _proUserAccessMeta,
          proUserAccess.isAcceptableOrUnknown(
              data['proUserAccess']!, _proUserAccessMeta));
    } else if (isInserting) {
      context.missing(_proUserAccessMeta);
    }
    if (data.containsKey('Favorite')) {
      context.handle(_isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(data['Favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  ModelFavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModelFavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ImagePath'])!,
      modelName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ModelName'])!,
      proUserAccess: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}proUserAccess'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}Favorite'])!,
    );
  }

  @override
  $ModelFavoriteTable createAlias(String alias) {
    return $ModelFavoriteTable(attachedDatabase, alias);
  }
}

class ModelFavoriteData extends DataClass
    implements Insertable<ModelFavoriteData> {
  final int id;
  final String path;
  final String modelName;
  final bool proUserAccess;
  final bool isFavorite;
  const ModelFavoriteData(
      {required this.id,
      required this.path,
      required this.modelName,
      required this.proUserAccess,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['Id'] = Variable<int>(id);
    map['ImagePath'] = Variable<String>(path);
    map['ModelName'] = Variable<String>(modelName);
    map['proUserAccess'] = Variable<bool>(proUserAccess);
    map['Favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  ModelFavoriteCompanion toCompanion(bool nullToAbsent) {
    return ModelFavoriteCompanion(
      id: Value(id),
      path: Value(path),
      modelName: Value(modelName),
      proUserAccess: Value(proUserAccess),
      isFavorite: Value(isFavorite),
    );
  }

  factory ModelFavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelFavoriteData(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      modelName: serializer.fromJson<String>(json['modelName']),
      proUserAccess: serializer.fromJson<bool>(json['proUserAccess']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'modelName': serializer.toJson<String>(modelName),
      'proUserAccess': serializer.toJson<bool>(proUserAccess),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  ModelFavoriteData copyWith(
          {int? id,
          String? path,
          String? modelName,
          bool? proUserAccess,
          bool? isFavorite}) =>
      ModelFavoriteData(
        id: id ?? this.id,
        path: path ?? this.path,
        modelName: modelName ?? this.modelName,
        proUserAccess: proUserAccess ?? this.proUserAccess,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('ModelFavoriteData(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('modelName: $modelName, ')
          ..write('proUserAccess: $proUserAccess, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, path, modelName, proUserAccess, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelFavoriteData &&
          other.id == this.id &&
          other.path == this.path &&
          other.modelName == this.modelName &&
          other.proUserAccess == this.proUserAccess &&
          other.isFavorite == this.isFavorite);
}

class ModelFavoriteCompanion extends UpdateCompanion<ModelFavoriteData> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> modelName;
  final Value<bool> proUserAccess;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const ModelFavoriteCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.modelName = const Value.absent(),
    this.proUserAccess = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModelFavoriteCompanion.insert({
    required int id,
    required String path,
    required String modelName,
    required bool proUserAccess,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        path = Value(path),
        modelName = Value(modelName),
        proUserAccess = Value(proUserAccess),
        isFavorite = Value(isFavorite);
  static Insertable<ModelFavoriteData> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? modelName,
    Expression<bool>? proUserAccess,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'Id': id,
      if (path != null) 'ImagePath': path,
      if (modelName != null) 'ModelName': modelName,
      if (proUserAccess != null) 'proUserAccess': proUserAccess,
      if (isFavorite != null) 'Favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModelFavoriteCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? modelName,
      Value<bool>? proUserAccess,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return ModelFavoriteCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      modelName: modelName ?? this.modelName,
      proUserAccess: proUserAccess ?? this.proUserAccess,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['Id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['ImagePath'] = Variable<String>(path.value);
    }
    if (modelName.present) {
      map['ModelName'] = Variable<String>(modelName.value);
    }
    if (proUserAccess.present) {
      map['proUserAccess'] = Variable<bool>(proUserAccess.value);
    }
    if (isFavorite.present) {
      map['Favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelFavoriteCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('modelName: $modelName, ')
          ..write('proUserAccess: $proUserAccess, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptHistoryTable extends PromptHistory
    with TableInfo<$PromptHistoryTable, PromptHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'Id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'Prompt', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, prompt, created];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompt_history';
  @override
  VerificationContext validateIntegrity(Insertable<PromptHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('Id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['Id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('Prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['Prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prompt};
  @override
  PromptHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Id'])!,
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Prompt'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
    );
  }

  @override
  $PromptHistoryTable createAlias(String alias) {
    return $PromptHistoryTable(attachedDatabase, alias);
  }
}

class PromptHistoryData extends DataClass
    implements Insertable<PromptHistoryData> {
  final int id;
  final String prompt;
  final DateTime created;
  const PromptHistoryData(
      {required this.id, required this.prompt, required this.created});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['Id'] = Variable<int>(id);
    map['Prompt'] = Variable<String>(prompt);
    map['created'] = Variable<DateTime>(created);
    return map;
  }

  PromptHistoryCompanion toCompanion(bool nullToAbsent) {
    return PromptHistoryCompanion(
      id: Value(id),
      prompt: Value(prompt),
      created: Value(created),
    );
  }

  factory PromptHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptHistoryData(
      id: serializer.fromJson<int>(json['id']),
      prompt: serializer.fromJson<String>(json['prompt']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prompt': serializer.toJson<String>(prompt),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  PromptHistoryData copyWith({int? id, String? prompt, DateTime? created}) =>
      PromptHistoryData(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('PromptHistoryData(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prompt, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptHistoryData &&
          other.id == this.id &&
          other.prompt == this.prompt &&
          other.created == this.created);
}

class PromptHistoryCompanion extends UpdateCompanion<PromptHistoryData> {
  final Value<int> id;
  final Value<String> prompt;
  final Value<DateTime> created;
  final Value<int> rowid;
  const PromptHistoryCompanion({
    this.id = const Value.absent(),
    this.prompt = const Value.absent(),
    this.created = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromptHistoryCompanion.insert({
    required int id,
    required String prompt,
    this.created = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        prompt = Value(prompt);
  static Insertable<PromptHistoryData> custom({
    Expression<int>? id,
    Expression<String>? prompt,
    Expression<DateTime>? created,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'Id': id,
      if (prompt != null) 'Prompt': prompt,
      if (created != null) 'created': created,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromptHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? prompt,
      Value<DateTime>? created,
      Value<int>? rowid}) {
    return PromptHistoryCompanion(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      created: created ?? this.created,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['Id'] = Variable<int>(id.value);
    }
    if (prompt.present) {
      map['Prompt'] = Variable<String>(prompt.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptHistoryCompanion(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('created: $created, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  late final $MyCreationTable myCreation = $MyCreationTable(this);
  late final $InspirationFavoriteTable inspirationFavorite =
      $InspirationFavoriteTable(this);
  late final $ModelFavoriteTable modelFavorite = $ModelFavoriteTable(this);
  late final $PromptHistoryTable promptHistory = $PromptHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favorite, myCreation, inspirationFavorite, modelFavorite, promptHistory];
}
