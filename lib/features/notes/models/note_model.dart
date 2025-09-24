import 'package:hive/hive.dart';
import 'package:task_3/core/utils/constants/hive_constants.dart';
part 'note_model.g.dart';

/// note model for local and api data
@HiveType(typeId: HiveConstants.noteTypeId)
class NoteModel extends HiveObject {
  /// unique identifier for the note
  @HiveField(0)
  final String id;

  /// note title
  @HiveField(1)
  final String title;

  /// note content/body
  @HiveField(2)
  final String content;

  /// note tag color
  @HiveField(3)
  final int colorIndex;

  /// creation timestamp
  @HiveField(4)
  final DateTime createdAt;

  /// last update timestamp
  @HiveField(5)
  final DateTime updatedAt;

  /// sync status - true if synced with server
  @HiveField(6)
  final bool isSynced;

  /// server id if synced
  @HiveField(7)
  final int? serverId;

  /// check if note is marked for deletion
  @HiveField(8)
  final bool isDeleted;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
    this.serverId,
    this.isDeleted = false,
  });

  /// create note from json
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['body'] ?? '',
      colorIndex: json['colorIndex'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      isSynced: json['isSynced'] ?? false,
      serverId: json['serverId'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  /// convert note to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': content,
      'colorIndex': colorIndex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced,
      'serverId': serverId,
      'isDeleted': isDeleted,
    };
  }

  /// convert to api json for server sync
  Map<String, dynamic> toApiJson() {
    return {
      'title': title,
      'body': content,
      'userId': 1, // mock user id for jsonplaceholder
    };
  }

  /// create copy with updated fields
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? colorIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    int? serverId,
    bool? isDeleted,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorIndex: colorIndex ?? this.colorIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      serverId: serverId ?? this.serverId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  /// mark note as synced
  NoteModel markAsSynced(int serverId) {
    return copyWith(
      isSynced: true,
      serverId: serverId,
      updatedAt: DateTime.now(),
    );
  }

  /// mark note as unsynced
  NoteModel markAsUnsynced() {
    return copyWith(isSynced: false, updatedAt: DateTime.now());
  }

  /// mark note as deleted
  NoteModel markAsDeleted() {
    return copyWith(isDeleted: true, updatedAt: DateTime.now());
  }

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: $content, '
        'colorIndex: $colorIndex, createdAt: $createdAt, updatedAt: $updatedAt, '
        'isSynced: $isSynced, serverId: $serverId, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
