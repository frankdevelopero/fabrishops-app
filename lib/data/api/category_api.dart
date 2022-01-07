import 'package:fabrishop/ui/constants/api_constants.dart';
import 'dart:convert';
import 'package:fabrishop/data/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<bool> createCategory(Category category, int storeId) async {
    final url = "${ApiConstants.domain}api/v1/category/add";
    final body = jsonEncode({
      "name": category.name,
      "description": category.description,
      "store": storeId
    });

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.statusCode);
    final parsed = jsonDecode(response.body);
    print(parsed);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
