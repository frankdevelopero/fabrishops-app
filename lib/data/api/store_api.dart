import 'package:fabrishop/data/models/store.dart';
import 'package:fabrishop/ui/constants/api_constants.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreApi {
  Future<Store> getStoreData({
    @required int idStore,
  }) async {
    final url = "${ApiConstants.domain}api/v1/store-data/" + idStore.toString();
    print(url);
    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    Store store;
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(parsed);
      final data = parsed["data"]["store"];
      final id = data['id'] as int;
      final name = data['name'] as String;
      final description = data['description'] as String;
      final slug = data['slug'] as String;
      final currency = data['currency'] as String;
      final image = data['image'] as String;

      PreferenceUtils.setString(SharedConstants.storeName, name);
      PreferenceUtils.setString(SharedConstants.storeDescription, description);
      PreferenceUtils.setString(SharedConstants.storeSlug, slug);
      PreferenceUtils.setString(SharedConstants.storeCurrency, currency);
      PreferenceUtils.setString(SharedConstants.storeImage, image);

      store = Store(
        id: id,
        name: name,
        description: description,
        slug: slug,
        currency: currency,
        image: image,
      );
    }
    return store;
  }
}
