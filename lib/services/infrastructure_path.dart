import 'dart:convert';

import 'package:map_poc/extra_models/server_reponse.dart';
import 'package:map_poc/models/index.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class InfrastructurePathService {
  static addPath(InfrastructurePaths paths) async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/saveInfrastructurePaths');
      var response = await http.post(url, body: json.encode(paths.toJson()));

      print(paths.toJson());
      final responseJson = {
        "inf_id": json.decode(response.body)['response']["inf_id"],
        "startX": json.decode(response.body)['response']["startX"].toDouble(),
        "startY": json.decode(response.body)['response']["startY"].toDouble(),
        "endX": json.decode(response.body)['response']["endX"].toDouble(),
        "endY": json.decode(response.body)['response']["endY"].toDouble(),
        "startLabel": json.decode(response.body)['response']["startLabel"],
        "endLabel": json.decode(response.body)['response']["endLabel"]
      };
      return InfrastructurePaths.fromJson(responseJson);
    } catch(err) {
      print('Error while saving infra path $err',);
      return null;
    }
    return paths;
  }

  static getInfraPathById(int infraId) async {
    try {
      var url = Uri.parse('${Env.baseUrl}public_api/getInfrastructurePaths?inf_id=$infraId');
      var response = await http.get(url);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["response"];
      List<InfrastructurePaths> paths =
      List<InfrastructurePaths>.from(data.map((model)=> InfrastructurePaths.fromJson({
        "inf_id": model['inf_id'],
        "startX": model['startX'].toDouble(),
        "startY": model['startY'].toDouble(),
        "endX": model['endX'].toDouble(),
        "endY": model['endY'].toDouble(),
        "startLabel": model['startLabel'],
        "endLabel": model['endLabel']
      })));

      return paths.toList();
    } catch(err) {
      print('Error while getting destination by infra id $err',);
      return null;
    }
  }
}