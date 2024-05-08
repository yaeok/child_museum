import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';

@freezed
class Report with _$Report {
  const factory Report({
    String? reportId,
    String? articleId,
    String? commentId,
    required String userId,
    required String report,
    required DateTime createdAt,
  }) = _Report;
}
