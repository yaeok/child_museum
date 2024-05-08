abstract class ReportRepository {
  Future<void> createReport(
      String articleId, String commentId, String userId, String report);
}
