import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tercerosApp/core/models/Nits.dart';

Future<Nit> fetchNit(String id) async {
  final response = await http.get('http://10.0.2.2:8080/api/nit/get/$id');
  if (response.statusCode == 200) {
    return Nit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fallo al cargar el listado');
  }
}

Future<List<Nit>> fetchNits() async {
  final response = await http.get('http://10.0.2.2:8080/api/nit/get');
  var nits = new List<Nit>();
  if (response.statusCode == 200) {
    List list = json.decode(response.body);
    nits = list.map((nit) => Nit.fromJson(nit)).toList();
    return nits;
    // return Nit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fallo al cargar el listado');
  }
}

Future<Nit> saveNit(Nit nit) async {
  final http.Response response =
      await http.post('http://10.0.2.2:8080/api/nit/create',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(nit.toJson()));
  if (response.statusCode == 201) {
    return Nit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fallo al guardar');
  }
}

Future<Nit> updateNit(String id, Nit nit) async {
  final http.Response response =
      await http.put('http://10.0.2.2:8080/api/nit/edit/$id',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(nit.toJson()));
  if (response.statusCode == 200) {
    return Nit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fallo al actualizar');
  }
}

Future<String> deleteNit(String id) async {
  final http.Response response =
      await http.delete('http://10.0.2.2:8080/api/nit/remove/$id');
  if (response.statusCode == 204) {
    return "Success";
  } else {
    throw Exception('Fallo al eliminar');
  }
}
