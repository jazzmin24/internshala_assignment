import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internshala_assignment/model/api_model.dart';

class ApiService {
  Future<List<InternshipModel>> fetchInternships() async {
    final url = Uri.parse('https://internshala.com/flutter_hiring/search');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
       // log('API call successful');

        final dynamic jsonResponse = jsonDecode(response.body);
       // log(jsonResponse.toString());

        if (jsonResponse is Map<String, dynamic> && jsonResponse['internships_meta'] is Map) {
          Map<String, dynamic> internshipsMeta = jsonResponse['internships_meta'];
          List<InternshipModel> internships = internshipsMeta.values.map((json) {
            return InternshipModel.fromJson(json);
          }).toList();
          // ignore: unused_local_variable
          for (var internship in internships) {
          }
          return internships;
        } else {
          throw Exception('Failed to parse internships data');
        }
      } else {
        throw Exception('Failed to load internships: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
