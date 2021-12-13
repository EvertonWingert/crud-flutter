import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';

class BilletRepository {
  final baseUrl = 'http://10.0.2.2:8000/api/billets';
  final client = http.Client();
  final box = GetStorage();

  Future<List<Billet>> getBillets() async {
    final token = box.read('token');

    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final billets = json.decode(response.body) as List;
      return billets.map((billet) => Billet.fromJson(billet)).toList();
    } else {
      throw Exception('Failed to load billets');
    }
  }

  Future<Billet> getBillet(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Billet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load billet');
    }
  }

  Future<Billet> createBillet(Billet billet) async {
    final token = box.read('token');
    final response = await client.post(
        Uri.parse(
          baseUrl,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(billet.toJson()));
    if (response.statusCode == 201) {
      return Billet.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create billet');
    }
  }

  Future<Billet> updateBillet(Billet billet) async {
    final token = box.read('token');

    final response = await client.put(Uri.parse('$baseUrl/${billet.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(billet.toJson()));
    if (response.statusCode == 200) {
      return Billet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update billet');
    }
  }

  Future<void> deleteBillet(int id) async {
    final token = box.read('token');

    final response = await client.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete billet');
    }
  }
}
