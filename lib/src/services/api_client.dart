import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<http.Response> getRequest({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    // Construct the full URL with query parameters
    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

    // Make the GET request
    final response = await http.get(uri, headers: headers);

    _handleResponse(response);

    return response;
  }

  Future<http.Response> postRequest({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    // Construct the full URL
    final uri = Uri.parse('$baseUrl$endpoint');

    // Make the POST request
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    _handleResponse(response);

    return response;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
