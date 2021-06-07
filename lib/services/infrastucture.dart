import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:map_poc/models/index.dart';
import '../env.dart';

class InfrastructureService {
  static getInfrastructure() async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/getInfrastructure');
      var response = await http.get(url);
      print(json.decode(response.body)['response']);
      return json.decode(response.body)['response'];
    } catch (err) {
      print(
        'Error while getting infras $err',
      );
      return null;
    }
  }

  static addInfrastructure(String title) async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/saveInfrastructure');
      var response = await http.post(url, body: json.encode({
        'title': title
      }));
      return json.decode(response.body)['response']["id"];
    } catch (err) {
      print(
        'Error while saving infras $err',
      );
      return null;
    }
  }
}
