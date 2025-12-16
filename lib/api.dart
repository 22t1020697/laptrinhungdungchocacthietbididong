import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nhu_project/model/product.dart';

/// Service class để gọi API sản phẩm từ FakeStore API
class Api {
  // Singleton pattern
  static final Api _instance = Api._internal();
  factory Api() => _instance;
  Api._internal();

  static const String _baseUrl = 'https://fakestoreapi.com';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Lấy danh sách tất cả sản phẩm
  ///
  /// Trả về [List<Product>] nếu thành công, list rỗng nếu có lỗi
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      }

      debugPrint('API Error: Status code ${response.statusCode}');
      return [];
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return [];
    }
  }

  /// Lấy sản phẩm theo ID
  Future<Product?> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return null;
    }
  }

  /// Lấy sản phẩm theo danh mục
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get('/products/category/$category');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return [];
    }
  }
}

/// Global instance để sử dụng trong app
final Api productApi = Api();
