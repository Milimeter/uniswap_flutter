

// Function to get the ABI of a pool address
import 'dart:convert';

import '../services/api_client.dart';

Future<String> getPoolAbi({
  required ApiClient apiClient,
  required String poolAddress,
  required String apiKey,
}) async {
  final response = await apiClient.getRequest(
    endpoint: '',
    queryParams: {
      'module': 'contract',
      'action': 'getabi',
      'address': poolAddress,
      'apikey': apiKey,
    },
  );

  final data = jsonDecode(response.body);
  if (data['status'] == '1') {
    return data['result'];
  } else {
    throw Exception('Failed to fetch ABI: ${data['message']}');
  }
}