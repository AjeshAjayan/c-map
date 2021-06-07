import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:map_poc/env.dart';
import 'package:map_poc/extra_models/server_reponse.dart';
import 'package:map_poc/models/designation.dart';

class DesignationService {

  static addDesignation(Designation designation) async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/saveDestination');
      var response = await http.post(url, body: json.encode(designation.toJson()));
      print(json.decode(response.body)['response']);
      final jsonResponse = {
        "inf_id": json.decode(response.body)['response']['inf_id'],
        "x": json.decode(response.body)['response']['x'].toDouble(),
        "y": json.decode(response.body)['response']['y'].toDouble(),
        "label": json.decode(response.body)['response']['label']
      };

      return Designation.fromJson(jsonResponse);
    } catch(err) {
      print('Error while saving designation $err',);
      return null;
    }
  }

  static getDestinationsByInfraId(int infraId) async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/getDestination?inf_id=$infraId');
      var response = await http.get(url);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["response"];
      List<Designation> destinations =
        List<Designation>.from(data.map((model)=> Designation.fromJson({
          "inf_id": model['inf_id'],
          "x": model['x'].toDouble(),
          "y": model['y'].toDouble(),
          "label": model['label']
        })));

      return destinations.toList();
    } catch(err) {
      print('Error while getting destination by infra id $err',);
      return null;
    }
  }
}