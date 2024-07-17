import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:internshala_assignment/api/api_service.dart';
import 'package:internshala_assignment/model/api_model.dart';

class FilterProvider extends ChangeNotifier {
  //============= getting list
  List<InternshipModel> internships = [];
  Future<void> fetchInternships() async {
    try {
      internships = await ApiService().fetchInternships();
      // filteredInternships = List.from(
      //     internships); // Initialize filtered list with all internships
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch internships: $e');
    }
  }

  List<String> profile = [];
  List<String> duration = [];
  List<String> city = [];
  List<InternshipModel> filteredInternships = [];

  void profileFilterListUpdate(List<String> pl) {
    profile = pl;
    notifyListeners();
  }

  void durationFilterListUpdate(List<String> dl) {
    duration = dl;
    notifyListeners();
  }

  void cityFilterListUpdate(List<String> cl) {
    city = cl;
    notifyListeners();
  }

  void filterInternships() {
    List<InternshipModel> tempFilteredInternships = internships;

    if (profile.isNotEmpty) {
      tempFilteredInternships = tempFilteredInternships
          .where((internship) => profile.contains(internship.title))
          .toList();
    }

    if (duration.isNotEmpty) {
      tempFilteredInternships = tempFilteredInternships
          .where((internship) => duration.contains(internship.duration))
          .toList();
    }

    if (city.isNotEmpty) {
      tempFilteredInternships = tempFilteredInternships.where((internship) {
        bool matchesLocation =
            city.isEmpty || internship.locationNames.any(city.contains);
        return matchesLocation;
      }).toList();
    }

    filteredInternships = tempFilteredInternships;

    notifyListeners();
  }

  //============== clear filters
  void clearFilters() {
    filteredInternships = [];
    city = [];
    duration = [];
    profile = [];
    notifyListeners();
  }
}
