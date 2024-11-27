import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpConnector {
  //192.168.1.3
  final String baseUrl = 'http://192.168.1.3:6968/students';

  Future<Map<String, dynamic>> getStudentByRegNo(String regNo) async {
    final url = Uri.parse('$baseUrl/Student/$regNo');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching student: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final url = Uri.parse('$baseUrl/Student/all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch all students. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching all students: $e');
    }
  }

  Future<Map<String, dynamic>> createStudent(Map<String, dynamic> studentData) async {
    final url = Uri.parse('$baseUrl/create');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(studentData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating student: $e');
    }
  }

  Future<String> deleteStudent(String regNo) async {
    final url = Uri.parse('$baseUrl/delete/$regNo');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to delete student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting student: $e');
    }
  }

  Future<Map<String, dynamic>> updateStudent(String regNo, Map<String, dynamic> studentData) async {
    final url = Uri.parse('$baseUrl/Student/update/$regNo');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(studentData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating student: $e');
    }
  }

  Future<Map<String, dynamic>> addSubjectToStudent(String regNo, Map<String, dynamic> subjectData) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/addSubject');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subjectData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to add subject to student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding subject to student: $e');
    }
  }

  Future<Map<String, dynamic>> updateSubjectDetails(String regNo, String subjectCode, Map<String, dynamic> subjectData) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/Subject/$subjectCode');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subjectData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update subject. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating subject: $e');
    }
  }

  Future<Map<String, dynamic>> addClassToSubject(String regNo, String subjectCode, String classDate, Map<String, dynamic> attendHrData) async {
    final url = Uri.parse('$baseUrl/add-class/$regNo/$subjectCode/$classDate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(attendHrData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to add class to subject. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding class to subject: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchStudentSubjects(String regNo) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/subjects');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch student subjects. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching student subjects: $e');
    }
  }
}
