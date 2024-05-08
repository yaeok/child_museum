import 'package:child_museum/domain/repository/report.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IReportRepository implements ReportRepository {
  IReportRepository();

  final _reportDB = Firestore.report;

  @override
  Future<void> createReport(
      String articleId, String commentId, String userId, String report) async {
    final docId = _reportDB.doc().id;
    await _reportDB.doc(docId).set({
      'reportId': docId,
      'articleId': articleId,
      'commentId': commentId,
      'userId': userId,
      'report': report,
      'createdAt': DateTime.now(),
    });
  }
}

final reportRepositoryProvider = Provider<IReportRepository>(
  (ref) => IReportRepository(),
);
