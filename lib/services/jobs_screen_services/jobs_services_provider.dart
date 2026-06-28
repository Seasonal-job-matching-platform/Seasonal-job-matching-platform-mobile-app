import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/models/jobs_screen_models/paginated_jobs_response.dart';
import 'package:job_seeker/models/jobs_screen_models/recommended_jobs_response.dart';
import 'package:job_seeker/core/logger.dart';

final jobServiceProvider = Provider<JobsServicesProvider>((ref) {
  final dio = ref.watch(dioProvider);
  return JobsServicesProvider(dio);
});

class JobsServicesProvider {
  final Dio _dio;

  JobsServicesProvider(this._dio);

  String jobsPath = JOBS;

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await _dio.get(jobsPath);
      // AppLogger.info('Jobs API response: \nresponse.data=${response.data}');
      final List dataList = response.data as List;
      // Map id - ensure string
      final jobs = dataList.map((json) {
        // final fixed = Map<String, dynamic>.from(json);
        // if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
        return JobModel.fromJson(json);
      }).toList();
      return jobs;
    } on DioException catch (e) {
      AppLogger.error('Jobs fetch error: $e');
      throw _handleError(e);
    } catch (e, st) {
      AppLogger.error('Jobs unexpected error: $e\n$st');
      rethrow;
    }
  }

  /// Fetch jobs with pagination
  /// [page] is 0-indexed (first page is 0)
  /// Returns PaginatedJobsResponse with jobs and pagination metadata
  Future<PaginatedJobsResponse> fetchJobsPage(int page) async {
    try {
      final response = await _dio.get('$jobsPath?page=$page');
      // AppLogger.info('Jobs page $page API response: ${response.data}');
      return PaginatedJobsResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error('fetchJobsPage error: $e');
      throw _handleError(e);
    } catch (e, st) {
      AppLogger.error('fetchJobsPage unexpected error: $e\n$st');
      rethrow;
    }
  }

  /// Search jobs with server-side filtering and pagination
  Future<PaginatedJobsResponse> searchJobs(
    int page, {
    String? query,
    String? type,
    String? location,
    String? salaryType,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {'page': page};

      // Map to the specific parameter names provided: title, jobTypes, location
      if (query != null && query.isNotEmpty) queryParams['title'] = query;
      if (type != null && type.isNotEmpty) queryParams['jobTypes'] = type;
      if (location != null && location.isNotEmpty)
        queryParams['location'] = location;

      // arrangements, jobTypes, salaryTypes, location, title
      if (salaryType != null && salaryType.isNotEmpty)
        queryParams['salaryTypes'] = salaryType;

      final response = await _dio.get(
        '$jobsPath/filter',
        queryParameters: queryParams,
      );

      // AppLogger.info('Search Jobs page $page API response: ${response.data}');
      return PaginatedJobsResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error('searchJobs error: $e');
      throw _handleError(e);
    } catch (e, st) {
      AppLogger.error('searchJobs unexpected error: $e\n$st');
      rethrow;
    }
  }

  Future<JobModel> fetchJobById(String jobId) async {
    try {
      final response = await _dio.get('$jobsPath/$jobId');
      // AppLogger.info('JobById API response: ${response.data}');
      final fixed = Map<String, dynamic>.from(response.data as Map);
      if (fixed['id'] != null && fixed['id'] is! String) {
        fixed['id'] = fixed['id'].toString();
      }
      return JobModel.fromJson(fixed);
    } on DioException catch (e) {
      AppLogger.error('fetchJobById error: $e');
      throw _handleError(e);
    } catch (e, st) {
      AppLogger.error('JobById unexpected error: $e\n$st');
      rethrow;
    }
  }

  Future<RecommendedJobsResponse> fetchRecommendedJobs(String userId) async {
    try {
      final response = await _dio.get(getRecommendedJobs(userId));
      // AppLogger.info('RecommendedJobs API response: ${response.data}');
      return RecommendedJobsResponse.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.error('fetchRecommendedJobs error: $e');
      throw _handleError(e);
    } catch (e, st) {
      AppLogger.error('RecommendedJobs unexpected error: $e\n$st');
      rethrow;
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 400) return 'Invalid data provided.';
        if (statusCode == 401) return 'Unauthorized. Please login again.';
        if (statusCode == 404) return 'Resource not found.';
        if (statusCode == 500) return 'Server error. Please try again later.';
        return 'Something went wrong. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'No internet connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
