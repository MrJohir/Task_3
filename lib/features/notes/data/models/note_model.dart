import 'package:hive/hive.dart';
import '../../../../core/utils/constants/enums.dart';
import '../../domain/entities/note_entity.dart';



/// note model for data layer with Hive database integration
@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  int colorIndex;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  int syncStatusIndex;

  @HiveField(7)
  String? remoteId;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatusIndex,
    this.remoteId,
  });

  /// create note model from entity
  /// [entity] - Note entity to convert
  /// Returns: NoteModel instance
  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      colorIndex: entity.color.colorIndex,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      syncStatusIndex: entity.syncStatus.index,
      remoteId: entity.remoteId,
    );
  }

  /// create note model from JSON
  /// [json] - JSON map to convert
  /// Returns: NoteModel instance
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? json['body']?.toString() ?? '',
      colorIndex: json['colorIndex']?.toInt() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      syncStatusIndex: json['syncStatusIndex']?.toInt() ?? SyncStatus.pending.index,
      remoteId: json['remoteId']?.toString(),
    );
  }

  /// create note model from API response
  /// [json] - API response JSON
  /// [localId] - Local note ID
  /// Returns: NoteModel instance
  factory NoteModel.fromApiResponse(Map<String, dynamic> json, String localId) {
    return NoteModel(
      id: localId,
      title: json['title']?.toString() ?? '',
      content: json['body']?.toString() ?? '',
      colorIndex: 0, // default color for API notes
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      syncStatusIndex: SyncStatus.synced.index,
      remoteId: json['id']?.toString(),
    );
  }

  /// convert to entity
  /// Returns: NoteEntity instance
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      color: _getColorFromIndex(colorIndex),
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: _getSyncStatusFromIndex(syncStatusIndex),
      remoteId: remoteId,
    );
  }

  /// convert to JSON
  /// Returns: JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'colorIndex': colorIndex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'syncStatusIndex': syncStatusIndex,
      'remoteId': remoteId,
    };
  }

  /// convert to API request body
  /// Returns: JSON map for API request
  Map<String, dynamic> toApiJson() {
    return {
      'title': title,
      'body': content,
      'userId': 1, // default user ID for JSONPlaceholder
    };
  }

  /// create a copy with updated fields
  /// Returns: New NoteModel instance
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? colorIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatusIndex,
    String? remoteId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorIndex: colorIndex ?? this.colorIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatusIndex: syncStatusIndex ?? this.syncStatusIndex,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  /// get note color from index
  /// [index] - Color index
  /// Returns: NoteColor enum value
  NoteColor _getColorFromIndex(int index) {
    const colors = NoteColor.values;
    if (index >= 0 && index < colors.length) {
      return colors[index];
    }
    return NoteColor.grey; // default color
  }

  /// get sync status from index
  /// [index] - Sync status index
  /// Returns: SyncStatus enum value
  SyncStatus _getSyncStatusFromIndex(int index) {
    const statuses = SyncStatus.values;
    if (index >= 0 && index < statuses.length) {
      return statuses[index];
    }
    return SyncStatus.pending; // default status
  }

  /// get note color
  /// Returns: NoteColor enum value
  NoteColor get color => _getColorFromIndex(colorIndex);

  /// get sync status
  /// Returns: SyncStatus enum value
  SyncStatus get syncStatus => _getSyncStatusFromIndex(syncStatusIndex);

  /// check if note is synced
  /// Returns: true if note is synced
  bool get isSynced => syncStatus == SyncStatus.synced;

  /// check if note is pending sync
  /// Returns: true if note is pending sync
  bool get isPendingSync => syncStatus == SyncStatus.pending;

  /// check if sync failed
  /// Returns: true if sync failed
  bool get isSyncFailed => syncStatus == SyncStatus.failed;

  /// check if note is currently syncing
  /// Returns: true if note is syncing
  bool get isSyncing => syncStatus == SyncStatus.syncing;

  /// check if note has remote id
  /// Returns: true if note has remote id
  bool get hasRemoteId => remoteId != null && remoteId!.isNotEmpty;

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: ${content.length} chars, '
        'colorIndex: $colorIndex, createdAt: $createdAt, updatedAt: $updatedAt, '
        'syncStatusIndex: $syncStatusIndex, remoteId: $remoteId)';
  }
}