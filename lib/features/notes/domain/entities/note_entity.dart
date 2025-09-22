import 'package:equatable/equatable.dart';
import '../../../../core/utils/constants/enums.dart';

/// note entity representing a note in the domain layer
class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final NoteColor color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final String? remoteId;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });

  /// create a copy of note entity with updated fields
  /// Returns: New NoteEntity instance with updated values
  NoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    NoteColor? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    String? remoteId,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  /// check if note is synced with remote server
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

  /// get formatted creation date
  /// Returns: Formatted date string
  String get formattedCreatedAt {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  /// get formatted update date
  /// Returns: Formatted date string
  String get formattedUpdatedAt {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}';
    }
  }

  /// get note preview content (first 100 characters)
  /// Returns: Preview string
  String get preview {
    if (content.isEmpty) return 'No content';
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// check if note is empty
  /// Returns: true if both title and content are empty
  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  /// check if note has content
  /// Returns: true if note has title or content
  bool get hasContent => !isEmpty;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        color,
        createdAt,
        updatedAt,
        syncStatus,
        remoteId,
      ];

  @override
  String toString() {
    return 'NoteEntity(id: $id, title: $title, content: ${content.length} chars, '
        'color: $color, createdAt: $createdAt, updatedAt: $updatedAt, '
        'syncStatus: $syncStatus, remoteId: $remoteId)';
  }
}